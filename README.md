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
    customer = NetSuite::Customer.get(4) # => #<NetSuite::Customer:0x1042f59b8>
    customer.is_person                   # => true
    ```

<a name='extending'>
## Additions

* Please submit a pull request for any models or actions that you would like to be included. The API is quite large and so we will necessarily not cover all of it.
* Models should go into the `lib/netsuite/models/` directory.
* Actions should be placed in their respective subdirectory under `lib/netsuite/actions`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
