require 'set'

require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'
require 'netsuite/version'
require 'netsuite/attribute_support'
require 'netsuite/field_support'
require 'netsuite/record_support'
require 'netsuite/savon_support'
require 'netsuite/record_ref_support'

# ACTIONS
require 'netsuite/actions/add'
require 'netsuite/actions/get'
require 'netsuite/actions/initialize'

# RECORDS
require 'netsuite/records/bill_address'
require 'netsuite/records/customer'
require 'netsuite/records/customer_addressbook_list'
require 'netsuite/records/invoice'
require 'netsuite/records/record_ref'
require 'netsuite/records/ship_address'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
