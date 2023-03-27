[![Ruby](https://github.com/NetSweet/netsuite/actions/workflows/main.yml/badge.svg)](https://github.com/NetSweet/netsuite/actions/workflows/main.yml)
[![Slack Status](https://netsuite-slackin.fly.dev/badge.svg)](https://netsuite-slackin.fly.dev)
[![Gem Version](https://badge.fury.io/rb/netsuite.svg)](http://badge.fury.io/rb/netsuite)

# NetSuite SuiteTalk API Ruby Gem

* This gem will act as a wrapper around the NetSuite SuiteTalk Web Services API.
* The gem does not cover the entire API, only the subset contributors have used so far. Please submit a PR for any functionality that's missing!
* NetSuite is a complex system. There's a lot to learn and sparse resources available to learn from. Here's a list of [NetSuite Development Resources](https://github.com/NetSweet/netsuite/wiki/NetSuite-Development-Resources).

# Help & Support

Join the [Slack channel](https://netsuite-slackin.fly.dev) for help with any NetSuite issues. Please do not post usage questions as issues in GitHub.

There is some additional helpful resources for NetSuite development [listed here](https://dashboard.suitesync.io/docs/resources#netsuite).

# Testing

Before contributing a patch make sure all existing tests pass.

```shell
git clone git://github.com/NetSweet/netsuite.git
cd netsuite

bundle
bundle exec rspec
```

# Installation

Add this line to your application's Gemfile:

```
gem 'netsuite'
```

If you'd like more accurate time conversion support, include the `tzinfo` gem.

This gem is built for Ruby 2.6.x+, but should work on older versions down to 1.9. There's a [1-8-stable](https://github.com/NetSweet/netsuite/tree/1-8-stable) branch for Ruby 1.8.x support.

## Configuration

The most important thing you'll need is your NetSuite account ID. Not sure how to find your account ID? [Here's a guide.](http://mikebian.co/find-netsuite-web-services-account-number/)

How you connect to NetSuite has changed a lot over the years and differs between API versions. For instance:

* Older API versions (~2015) allowed authentication via username and password
* Newer API versions (> 2016) still allowed for username and password authentication, but required an application ID
* "OAuth", which requires four separate keys to be manually generated, was supported sometime after 2015
* API versions greater than 2018_2 require `endpoint` to be set directly ([more info](https://github.com/NetSweet/netsuite/pull/473))

Here's an example connection configuration. You don't want to actually use username + password config; Token Based Authentication is detailed [in a separate section](#token-based-authentication):

```ruby
NetSuite.configure do
  reset!

  # production & sandbox account numbers will differ
  account  'TSTDRV1576318'
  api_version '2018_2'

  # password-based login information
  # in most cases you should use Token Based Authentication instead
  email 'email@example.com'
  password 'password'
  role 10

  # recent API versions require an account-specific endpoint to be set
  # use `NetSuite::Utilities.data_center_url('TSTDRV1576318')` to retrieve WSDL URL
  # you'll want to do this in a background process and strip the protocol out of the return string
  wsdl_domain 'tstdrv1576318.suitetalk.api.netsuite.com'

  # the endpoint indicated in the > 2018_2 wsdl is invalid
  # you must set the endpoint directly
  # https://github.com/NetSweet/netsuite/pull/473
  endpoint "https://#{wsdl_domain}/services/NetSuitePort_#{api_version}"
end
```

The `wsdl_domain` configuration is most important. Note that if you use `wsdl` or other configuration options below, you'll want to look at the configuration source to understand more about how the different options interact with each other. Some of the configuration options will mutate the state of other options.

Here's the various options that are are available for configuration:

```ruby
NetSuite.configure do
  reset!

  api_version	'2018_2'

  # optionally specify full WSDL URL (to switch to sandbox, for example)
  wsdl          "https://webservices.sandbox.netsuite.com/wsdl/v#{api_version}_0/netsuite.wsdl"

  # if your datacenter is being switched, you'll have to manually set your WSDL location
  wsdl          "https://webservices.na2.netsuite.com/wsdl/v#{api_version}_0/netsuite.wsdl"

  # or specify the wsdl_domain if you want to specify the datacenter and let the configuration
  # construct the full wsdl location - e.g. "https://#{wsdl_domain}/wsdl/v#{api_version}_0/netsuite.wsdl"
  wsdl_domain   "webservices.na2.netsuite.com"

  # often the NetSuite servers will hang which would cause a timeout exception to be raised
  # if you don't mind waiting (e.g. processing NS via a background worker), increasing the timeout should fix the issue
  read_timeout  100_000

  # you can specify a file or file descriptor to send the log output to (defaults to STDOUT)
  # If using within a Rails app, consider setting to `Rails.logger` to leverage existing
  # application-level log configuration
  log           File.join(Rails.root, 'log/netsuite.log')

  # Defaults to :debug level logging for Savon API calls. Decrease the verbosity
  # by setting log_level to `:info`, for example
  # log_level   :debug

  # password-based login information
  # in most cases you should use Token Based Authentication instead
  email    	  'email@domain.com'
  password 	  'password'
  account   	'12345'
  role        1111

  # optional, ensures that read-only fields don't cause API errors
  soap_header	'platformMsgs:preferences' => {
    'platformMsgs:ignoreReadOnlyFields' => true,
  }
end
```

If you are using username + password authentication (which you shouldn't be!) *and* you'd like to use an API endpoint greater than 2015_1, you'll need to specify an application ID:

```ruby
NetSuite::Configuration.soap_header = {
   'platformMsgs:ApplicationInfo' => {
      'platformMsgs:applicationId' => 'your-netsuite-app-id'
   }
}
```

### Token Based Authentication

OAuth credentials are supported and the recommended authentication approach. [Learn more about how to set up Token Based Authentication here](http://mikebian.co/using-netsuites-token-based-authentication-with-suitetalk/).

```ruby
NetSuite.configure do
  reset!

  account       ENV['NETSUITE_ACCOUNT']

  consumer_key     ENV['NETSUITE_CONSUMER_KEY']
  consumer_secret  ENV['NETSUITE_CONSUMER_SECRET']
  token_id         ENV['NETSUITE_TOKEN_ID']
  token_secret     ENV['NETSUITE_TOKEN_SECRET']

  # oauth does not work with API versions less than 2015_2
  api_version      '2016_2'

  # the endpoint indicated in the > 2018_2 WSDL is invalid
  # you must set the endpoint directly
  # https://github.com/NetSweet/netsuite/pull/473
  endpoint "https://#{wsdl_domain}/services/NetSuitePort_#{api_version}"
end
```

### Multi-Tenancy

If you're interacting with multiple NetSuite accounts, each in separate threads, you can enable multi-tenancy to prevent your configuration and caches from being shared between threads.

From your main thread, you'd want to enable multi-tenancy:

```ruby
NetSuite.configure do
  multi_tentant!
end
```

Note that `multi_tenant!` is a special configuration option which is _not_ effected by `reset!`.

Then in each child thread, you'd perform any configuration specific to the NetSuite account you're interacting with for that thread, all of which will be specific to that thread only:

```ruby
NetSuite.configure do
  reset!

  account ENV['NETSUITE_ACCOUNT']

  # The rest of your usual configuration...
end
```

# Usage

## CRUD Operations

```ruby
# get a customer
customer = NetSuite::Records::Customer.get(:internal_id => 4)
customer.is_person

# or
NetSuite::Records::Customer.get(4)


# get a list of customers
customers = NetSuite::Records::Customer.get_list(:list => [4, 5, 6])

# randomly assign a task
customer_support_reps = [12345, 12346]

task = NetSuite::Records::Task.new(
	:title => 'Take Care of a Customer',
	:assigned => NetSuite::Records::RecordRef.new(internal_id: customer_support_reps.sample),
	:due_date => DateTime.now + 1,
	:message => "Take care of this"
)

task.add

# this will only work on OS X, open a browser to the record that was just created
`open https://system.sandbox.netsuite.com/app/crm/calendar/task.nl?id=#{invoice.internal_id}`

# update a field on a record
task.update(message: 'New Message')

# delete a record
task.delete

# refresh/reload a record (helpful after adding the record for the first time)
task.refresh

# using get_select_value with a standard record
NetSuite::Records::BaseRefList.get_select_value(
  recordType: 'serviceSaleItem',
  field: 'taxSchedule'
)

# get options for a custom sublist field (i.e. transaction column fields)
NetSuite::Records::BaseRefList.get_select_value(
  field: 'custcol69_2',
  sublist: 'itemList',
  recordType: 'salesOrder'
)

# output names of options available for a custom field
options = NetSuite::Records::BaseRefList.get_select_value(
  field: 'custbody_order_source',
  recordType: 'invoice'
)
options.base_refs.map(&:name)
```

## Uploading/Attaching Files

```ruby
file = NetSuite::Records::File.new(
  content: Base64.encode64(File.read('/path/to/file')),
  name: 'Invoice.pdf',
)
file.add

invoice = NetSuite::Records::Invoice.get(internal_id: 1)
invoice.attach_file(NetSuite::Records::RecordRef.new(internal_id: file.internal_id))
```

## Custom Records & Fields

```ruby
# updating a custom field list on a record

# you need to push ALL the values of ALL of the custom fields that you want set on the record
# you can't just push the values of the fields that you want to update: all of the values of
# other fields will then fall back to their default values

contact = NetSuite::Records::Contact.get(12345)
contact.custom_field_list.custentity_alistfield = { internal_id: 1 }
contact.custom_field_list.custentity_abooleanfield = true
contact.update(custom_field_list: contact.custom_field_list)

# getting a custom record
record = NetSuite::Records::CustomRecord.get(
  # custom record type
  type_id: 10,
  # reference to instance of the custom record type
  internal_id: 100
)

# getting a list of custom records
records = NetSuite::Records::CustomRecord.get_list(
  # netsuite internalIDs
  list: [1,2,3],
  # only needed for a custom record
  type_id: 1234
)

# adding a custom record
record = NetSuite::Records::CustomRecord.new
record.rec_type = NetSuite::Records::CustomRecord.new(internal_id: 10)
record.custom_field_list.custrecord_locationstate = "New Jersey"
record.add

# updating a custom record
record = NetSuite::Records::CustomRecord.new(internal_id: 100)
record.custom_field_list.custrecord_locationstate = "New Jersey"
record.update(custom_field_list: record.custom_field_list, rec_type: NetSuite::Records::CustomRecord.new(internal_id: 10))

# using get_select_value with a custom record
NetSuite::Records::BaseRefList.get_select_value(
  field: 'custrecord_something',
  customRecordType: {
    '@internalId' => 10,
    '@xsi:type' => 'customRecord'
  }
)
```

## Null Fields

```ruby
# updating a field on a record to be null
invoice = NetSuite::Records::Invoice.get(12345)
invoice.update(null_field_list: 'shipMethod')

# updating multiple fields on a record to be null
invoice.update(null_field_list: ['shipAddressList', 'shipMethod'])

# updating a custom fields on a record to be null, using custom field ID
invoice.update(null_field_list: 'custBody9')
```

## Searching

```ruby
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

# find the Avalara tax item. Some records don't support search.
all_sales_taxes = NetSuite::Utilities.backoff { NetSuite::Records::SalesTaxItem.get_all }
ns_tax_code = all_sales_taxes.detect { |st| st.item_id == 'AVATAX' }

# searching for custom records
NetSuite::Records::CustomRecord.search(
  basic: [
    {
      field: 'recType',
      operator: 'is',
      # custom record type
      value: NetSuite::Records::CustomRecordRef.new(:internal_id => 10),
    }
  ]
).results

# advanced search building on saved search
NetSuite::Records::Customer.search({
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
          # type is needed for all search fields
          type: 'SearchMultiSelectCustomField',
          value: [
            NetSuite::Records::CustomRecordRef.new(:internal_id => 1),
            NetSuite::Records::CustomRecordRef.new(:internal_id => 2),
          ]
        },
      	{
      	  field: 'custbody_internetorder',
      	  type: 'SearchBooleanCustomField',
      	  value: true
      	}
      ]
    }
  ]
}).results

NetSuite::Records::SalesOrder.search({
  criteria: {
    basic: [
      # NOTE do not search for more than one transaction type at a time!
      {
        field: 'type',
        operator: 'anyOf',
        value: [ "_invoice"]
      },
      {
        field: 'tranDate',
        operator: 'within',
        # this is needed for date range search requests, for date requests with a single param type is not needed
        type: 'SearchDateField',
        value: [
          # NetSuite requires iso8601 time format
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

  # the column syntax is a WIP. This will change in the future.
  columns: {
    'tranSales:basic' => [
      'platformCommon:internalId/' => {},
      'platformCommon:email/' => {},
      'platformCommon:tranDate/' => {},
      # If you include columns that are only part of the *SearchRowBasic (ie. TransactionSearchRowBasic),
      # they'll be readable on the resulting record just like regular fields (my_record.close_date).
      'platformCommon:closeDate/' => {}
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
          '@scriptId' => 'custitem_apcategoryforsales',
          # Or, for API versions 2013.1 and older:
          # '@internalId' => 'custitem_apcategoryforsales',
          '@xsi:type' => "platformCore:SearchColumnSelectCustomField"
        }
      ]
    ]
  },

  preferences: {
    page_size: 10,

    # only returning body fields increases performance!
    body_fields_only: true
  }
}).results

# Search for SalesOrder records with a "Pending Approval" status using the TransactionStatus enum value.
# https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2016_2/schema/enum/transactionstatus.html

NetSuite::Records::SalesOrder.search(
  criteria: {
    basic: [
      {
        field: 'type',
        operator: 'anyOf',
        value: ['_salesOrder'],
      },
      {
        field: 'status',
        operator: 'anyOf',
        value: ['_salesOrderPendingApproval'],
      },
    ],
  },
)

NetSuite::Records::ItemFulfillment.search({
  criteria: {
    basic: [
      {
        field: 'type',
        operator: 'anyOf',
        type: 'SearchEnumMultiSelectField',
        value: ["_itemFulfillment"]
      },
      {
        field: 'lastModifiedDate',
        type: 'SearchDateField',
        operator: 'within',
        value: [
          DateTime.now - 2.hours,
          DateTime.now
        ]
      }
    ],
    createdFromJoin: [
      {
        field: 'type',
        operator: 'anyOf',
        value: [ '_salesOrder' ]
      },
      {
        field: 'internalIdNumber',
        operator: 'notEmpty'
      }
    ]
  },
  preferences: {
    pageSize: 1000,
    bodyFieldsOnly: false
  }
}).results

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

# item search
NetSuite::Records::InventoryItem.search({
  criteria: {
    basic: [
      {
        field: 'type',
        operator: 'anyOf',
        type: 'SearchEnumMultiSelectField',
        value: [
          '_inventoryItem',

          # note that the naming conventions aren't consistent: AssemblyItem != _assemblyItem
          # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/enum/itemtype.html
          '_assembly'
        ]
      },
      {
        field: 'isInactive',
        value: false
      }
    ]
  }
}).results.first

# set body_fields_only = false to include the majority of lists associated with records in the XML response
# Some lists you just can't include with searches (a customer's AddressBookList, for example)

# In order to get the full record data for those records whose lists aren't included when body_fields_only = false
# you will have to run a get_list call on the resulting internalIds returned from the search you've executed

search = NetSuite::Records::File.search({
  preferences: {
    body_fields_only: false,
    page_size: 20
  }
})

search.results_in_batches do |batch|
  batch.each do |file|
    next unless file.file_type == "_JAVASCRIPT"
    puts Base64.decode64(file.content)
  end
end

# the getList operation
NetSuite::Records::CustomRecord.get_list(
  # netsuite internalIDs
  list: [1,2,3],
  # only needed for a custom record
  type_id: 1234,
  # allow inclomplete results (defaults to false)
  allow_incomplete: true
).each do |record|
  # do your thing...
end

# Adding a Customer Deposit example. The customer associated with the
# sales order would be linked to the deposit.

deposit = CustomerDeposit.new
deposit.sales_order = RecordRef.new(internal_id: 7279)
deposit.payment = 20
deposit.add
```

## Getting Deleted Records

```ruby
response = NetSuite::Records::LotNumberedInventoryItem.get_deleted({
  criteria: [
    {
      # If you don't specify a type criteria, you'll get all deleted records,
      # regardless of the type of record you called this on.
      field: 'type',
      operator: 'anyOf',
      value: 'lotNumberedInventoryItem',
    }
  ],
})

Array(response.body.fetch(:deleted_record_list)).first
# => {
#      :deleted_date => Wed, 16 Feb 2022 17:43:45 -0800,
#      :record => {
#        :name => "My Item",
#        :@internal_id => "12485",
#        :@type => "lotNumberedInventoryItem",
#        :"@xsi:type" => "platformCore:RecordRef"
#      }
#    }

# deleted_record_list could be:
#   nil - No records matching criteria were deleted
#   Hash - A single record matching criteria was deleted
#   Array - Multiple records matching criteria were deleted

# Simple pagination
page = 1
begin
  response = NetSuite::Records::LotNumberedInventoryItem.get_deleted({
    criteria: [
      # your criteria
    ],
    page: page,
  })

  # Do your thing with response.body.fetch(:deleted_record_list)

  page += 1
end until page > Integer(response.fetch(:total_pages))
```

## Non-standard Operations

```ruby
# making a call that hasn't been implemented yet
NetSuite::Configuration.connection.call :get_customization_id, message: {
  'platformMsgs:customizationType' => { '@getCustomizationType' => 'customRecordType'},
  'platformMsgs:includeInactives' => 'false'
}

server_time_response = NetSuite::Configuration.connection.call :get_server_time
server_time_response.body[:get_server_time_response][:get_server_time_result][:server_time]

# getting a list of states
states = NetSuite::Configuration.connection.call(:get_all, message: {
  'platformCore:record' => {
    '@recordType' => 'state'
  }
})
states.to_array.first[:get_all_response][:get_all_result][:record_list][:record].map { |r| { country: r[:country], abbr: r[:shortname], name: r[:full_name] } }
```
