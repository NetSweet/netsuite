require 'set'

require 'netsuite/version'
require 'netsuite/configuration'
require 'netsuite/errors'
require 'netsuite/response'

# NAMESPACES
require 'netsuite/namespaces/platform_core'
require 'netsuite/namespaces/platform_common'
require 'netsuite/namespaces/list_acct'
require 'netsuite/namespaces/list_rel'
require 'netsuite/namespaces/tran_sales'
require 'netsuite/namespaces/setup_custom'

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
require 'netsuite/actions/update'

# SUBRECORDS
require 'netsuite/records/bill_address'
require 'netsuite/records/custom_field'
require 'netsuite/records/custom_field_list'
require 'netsuite/records/customer_addressbook'
require 'netsuite/records/customer_addressbook_list'
require 'netsuite/records/ship_address'
require 'netsuite/records/record_ref'
require 'netsuite/records/invoice_item'
require 'netsuite/records/invoice_item_list'
require 'netsuite/records/custom_record_ref'
require 'netsuite/records/duration'

# RECORDS
require 'netsuite/records/customer'
require 'netsuite/records/invoice'
require 'netsuite/records/non_inventory_sale_item'
require 'netsuite/records/classification'
require 'netsuite/records/custom_record'
require 'netsuite/records/custom_record_type'
require 'netsuite/records/job'
require 'netsuite/records/customer_payment'

module NetSuite

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
