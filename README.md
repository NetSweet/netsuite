# Netsuite

* This gem will act as a wrapper around the NetSuite SuiteTalk WebServices API. Wow, that is a mouthful.
* The gem does not cover the entire API, only the subset that we have found useful to cover so far.
* [Extending the wrapper](#extending) is pretty simple. See below for an example.

## Installation

Add this line to your application's Gemfile:

    gem 'netsuite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install netsuite

## Usage

### Customer

* Initializing a customer can be done using a hash of attributes.

#### Get

* Retrieves the customer by internalId.

    ```Ruby
    customer = NetSuite::Records::Customer.get(:internal_id => 4) # => #<NetSuite::Records::Customer:0x1042f59b8>
    customer.is_person                            # => true
    ```

<a name='extending'>
## Additions

* Please submit a pull request for any models or actions that you would like to be included. The API is quite large and so we will necessarily not cover all of it.
* Records should go into the `lib/netsuite/records/` directory.
* Actions should be placed in their respective subdirectory under `lib/netsuite/actions`.
* Example:

    ```Ruby
    # lib/netsuite/actions/customer/add.rb

    module NetSuite
      module Actions
        module Customer
          class Add

            def initialize(attributes = {})
              @attributes = attributes
            end

            def self.call(attributes)
              new(attributes).call
            end

            def call
              response = NetSuite::Configuration.connection.request :add do
                soap.header =  NetSuite::Configuration.auth_header
                soap.body = {
                  :entityId    => @attributes[:entity_id],
                  :companyName => @attributes[:company_name],
                  :unsubscribe => @attributes[:unsubscribe]
                }
              end
              success = response.to_hash[:add_response][:write_response][:status][:@is_success] == 'true'
              body    = response.to_hash[:add_response][:write_response][:base_ref]
              NetSuite::Response.new(:success => success, :body => body)
            end

          end
        end
      end
    end

    response = NetSuite::Actions::Customer::Add.call(
      :entity_id    => 'Shutter Fly',
      :company_name => 'Shutter Fly, Inc.',
      :unsubscribe  => false
    )                 # => #<NetSuite::Response:0x1041f64b5>
    response.success? # => true
    response.body     # => { :internal_id => '979', :type => 'customer' }
    ```

## Gotchas

  * The Initialize Action duck-punches the .initialize method on any class that includes it.
    This has not proven to be a issue yet, but should be taken into account when analyzing any
    strange issues with the gem.
  * Some records define a 'class' field. Defining a 'class' field on a record overrides the
    #class and #class= methods for this class. This is very obviously a problem.  You can,
    instead, define a 'klass' field that will be turned into 'class' before being submitted
    to the API. The Invoice record has an example of this.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Fields and RecordRefs

Note that some record attributes are specified as Fields while others are specified as RecordRefs. In some cases
attributes are actually RecordRefs in the schema, but we indicate them as Fields. Our experience has shown
this works as long as the attribute is only read from and is not written to. Writing a value for an attribute
that has been wrongly specified will result in an error. Be careful when initializing objects from other objects --
they may carry attributes that write to the new object.

As we build up this gem we will replace these inconsistent Fields with RecordRefs. Feel free to contribute new Record 
definitions to help us along.
