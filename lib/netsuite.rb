require 'set'

require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'
require 'netsuite/version'
require 'netsuite/attribute_support'
require 'netsuite/field_support'
require 'netsuite/record_support'
require 'netsuite/savon_support'

# ACTIONS
require 'netsuite/actions/add'
require 'netsuite/actions/get'
require 'netsuite/actions/initialize'

# RECORDS
require 'netsuite/records/customer_addressbook_list'

# ENTITIES
require 'netsuite/entities/customer'

# TRANSACTIONS
require 'netsuite/transactions/invoice'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
