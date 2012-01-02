require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'
require 'netsuite/version'
require 'netsuite/field_support'

# ACTIONS
require 'netsuite/actions/support'
require 'netsuite/actions/add'
require 'netsuite/actions/get'

# ENTITIES
require 'netsuite/entities/customer'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
