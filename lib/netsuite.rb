require 'set'

require 'netsuite/version'
require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'

# NAMESPACES
require 'netsuite/namespaces/platform_core'
require 'netsuite/namespaces/platform_common'
require 'netsuite/namespaces/list_acct_typ'
require 'netsuite/namespaces/list_rel'
require 'netsuite/namespaces/tran_sales'

# SUPPORT
require 'netsuite/support/attributes'
require 'netsuite/support/fields'
require 'netsuite/support/record_refs'
require 'netsuite/support/records'
require 'netsuite/support/requests'

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
require 'netsuite/records/non_inventory_sale_item'
require 'netsuite/records/invoice_item_list'
require 'netsuite/records/classification'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
