require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'
require 'netsuite/version'

# ACTIONS
require 'netsuite/actions/customer/get'

# MODELS
require 'netsuite/models/customer'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
