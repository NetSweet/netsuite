# NetSuite Ruby SuiteTalk Gem

* This gem will act as a wrapper around the NetSuite SuiteTalk WebServices API. Wow, that is a mouthful.
* The gem does not cover the entire API, only the subset that we have found useful to cover so far.
* Extending the wrapper is pretty simple. Check out the [contribution help doc](https://github.com/RevolutionPrep/netsuite/wiki/Contributing-to-the-Supported-NetSuite-API)
* NetSuite development is overall a pretty poor experience. We have a list of [NetSuite Development Resources](https://github.com/RevolutionPrep/netsuite/wiki/NetSuite-Development-Resources) that might make things a bit less painful.

## Installation

Add this line to your application's Gemfile:

    gem 'netsuite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install netsuite

This gem is built for ruby 1.9.x, checkout the [1-8-stable](https://github.com/RevolutionPrep/netsuite/tree/1-8-stable) branch for ruby 1.8.x support.

## Testing
Before contributing a patch make sure all existing tests pass.

```
git clone git://github.com/RevolutionPrep/netsuite.git
cd netsuite
bundle
bundle exec rspec
```
## Usage

### Configuration
```ruby
NetSuite.configure do
  reset!
  
  # optional, defaults to 2011_2
  api_version	'2012_1'
  
  # optionally specify full wsdl URL (to switch to sandbox, for example)
  wsdl          "https://webservices.sandbox.netsuite.com/wsdl/v#{api_version}_0/netsuite.wsdl"
  
  # or specify the sandbox flag if you don't want to deal with specifying a full URL
  sandbox	true
  
  # often the netsuite servers will hang which would cause a timeout exception to be raised
  # if you don't mind waiting (e.g. processing NS via DJ), increasing the timeout should fix the issue
  read_timeout  100000
  
  # you can specify a file or file descriptor to send the log output to (defaults to STDOUT)
  log           File.join(Rails.root, 'log/netsuite.log')
  
  # login information
  email    	'email@domain.com'
  password 	'password'
  account   	'12345'
  role      	1111
end
```

### Examples

```ruby
# retrieve a customer
customer = NetSuite::Records::Customer.get(:internal_id => 4)
customer.is_person

# or
NetSuite::Records::Customer.get(4).is_person

# randomly assign a task
customer_support_reps = [12345, 12346]

task = NetSuite::Records::Task.new(
	:title => 'Take Care of a Customer',
	:assigned => NetSuite::Records::RecordRef.new(customer_support_reps.sample),
	:due_date => DateTime.now + 1,
	:message => "Take care of this"
)

task.add

# this will only work on OS X, open a browser to the record that was just created
`open https://system.sandbox.netsuite.com/app/crm/calendar/task.nl?id=#{invoice.internal_id}`

task.update :message => 'New Message'

# basic search
search = NetSuite::Records::Customer.search({
  basic: [
    {
      field: 'companyName',
      operator: 'contains',
      value: company_name
    }
  ]
})

`open https://system.netsuite.com/app/common/entity/custjob.nl?id=#{search.results.first.internal_id}`

# advanced search building on saved search
search = NetSuite::Records::Customer.search({
  saved: 500,	# your saved search internalId
  basic: [
    {
      field: 'entityId',
      operator: 'hasKeywords',
      value: 'Assumption',
    },
    {
      field: 'stage',
      operator: 'anyOf',
      type: 'SearchMultiSelectCustomField',
      value: [
        '_lead', '_customer'
      ]
    },
    {
      field: 'customFieldList',
      value: [
        {
          field: 'custentity_acustomfield',
          operator: 'anyOf',
          # type is needed for multiselect fields
          type: 'SearchMultiSelectCustomField',
          value: [
            NetSuite::Records::CustomRecordRef.new(:internal_id => 1),
            NetSuite::Records::CustomRecordRef.new(:internal_id => 2),
          ]
        }
      ]
    }
  ]
})

# advanced search from stratch
search = NetSuite::Records::Transaction.search({
  criteria: {
    basic: [
      {
        field: 'type',
        operator: 'anyOf',
        type: 'SearchEnumMultiSelectField',
        value: [ "_invoice", "_salesOrder" ]
      },
      {
        field: 'tranDate',
        operator: 'within',
        # this is needed for date range search requests, for date requests with a single param type is not needed
        type: 'SearchDateField',
        value: [
          # the following format is equivilent to ISO 8601
          # Date.parse("1/1/2012").strftime("%Y-%m-%dT%H:%M:%S%z"),
          # Date.parse("30/07/2013").strftime("%Y-%m-%dT%H:%M:%S%z")

          # need to require the time library for this to work
          Time.parse("01/01/2012").iso8601,
          Time.parse("30/07/2013").iso8601,

          # or you can use a string. Note that the format below is different from the format of the above code
          # but it matches exactly what NS returns 
          # "2012-01-01T22:00:00.000-07:00",
          # "2013-07-30T22:00:00.000-07:00"
        ]
      }
    ],


    # equivilent to the 'Account' label in the GUI
    accountJoin: [
      {
        field: 'internalId',
        operator: 'noneOf',
        value: [ NetSuite::Records::Account.new(:internal_id => 215) ]
      }
    ],

    itemJoin: [
      {
        field: 'customFieldList',
        value: [
          {
            field: 'custitem_apcategoryforsales',
            operator: 'anyOf',
            type: 'SearchMultiSelectCustomField',
            value: [
              NetSuite::Records::Customer.new(:internal_id => 1),
              NetSuite::Records::Customer.new(:internal_id => 2),
            ]
          }
        ]
      }
    ]
  },
  
  # the column syntax is a WIP. This will change in the future
  columns: {
    'tranSales:basic' => [
      'platformCommon:internalId/' => {},
      'platformCommon:email/' => {},
      'platformCommon:tranDate/' => {}
    ],
    'tranSales:accountJoin' => [
      'platformCommon:internalId/' => {}
    ],
    'tranSales:contactPrimaryJoin' => [
      'platformCommon:internalId/' => {}
    ],
    'tranSales:customerJoin' => [
      'platformCommon:internalId/' => {}
    ],
    'tranSales:itemJoin' => [
      'platformCommon:customFieldList' => [
        'platformCore:customField/' => {
          '@internalId' => 'custitem_apcategoryforsales',
          '@xsi:type' => "platformCore:SearchColumnSelectCustomField"
        }
      ]
    ]
  },

  preferences: {
    page_size: 10
  }
})

# basic search with pagination / SearchMorewithId
search = NetSuite::Records::Customer.search(
  criteria: {
    basic: [
      {
        # no operator for booleans
        field: 'isInactive',
        value: false,
      },
    ]
  },

  preferences: {
    page_size: 10,
  }
)

search.results_in_batches do |batch|
  puts batch.map(&:internal_id)
end

```



