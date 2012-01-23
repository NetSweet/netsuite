require 'set'

require 'netsuite/version'
require 'netsuite/errors'
require 'netsuite/xml_logger'

module NetSuite
  autoload :Configuration, 'netsuite/configuration'
  autoload :Response,      'netsuite/response'

  module Namespaces
    autoload :ListAcct,       'netsuite/namespaces/list_acct'
    autoload :ListRel,        'netsuite/namespaces/list_rel'
    autoload :PlatformCommon, 'netsuite/namespaces/platform_common'
    autoload :PlatformCore,   'netsuite/namespaces/platform_core'
    autoload :TranCust,       'netsuite/namespaces/tran_cust'
    autoload :TranGeneral,    'netsuite/namespaces/tran_general'
    autoload :TranSales,      'netsuite/namespaces/tran_sales'
    autoload :SetupCustom,    'netsuite/namespaces/setup_custom'
  end

  module Support
    autoload :Actions,    'netsuite/support/actions'
    autoload :Attributes, 'netsuite/support/attributes'
    autoload :Fields,     'netsuite/support/fields'
    autoload :RecordRefs, 'netsuite/support/record_refs'
    autoload :Records,    'netsuite/support/records'
    autoload :Requests,   'netsuite/support/requests'
  end

  module Actions
    autoload :Add,        'netsuite/actions/add'
    autoload :Get,        'netsuite/actions/get'
    autoload :Initialize, 'netsuite/actions/initialize'
    autoload :Update,     'netsuite/actions/update'
  end

  module Records
    autoload :Account,                   'netsuite/records/account'
    autoload :BillAddress,               'netsuite/records/bill_address'
    autoload :Classification,            'netsuite/records/classification'
    autoload :CreditMemo,                'netsuite/records/credit_memo'
    autoload :CreditMemoItem,            'netsuite/records/credit_memo_item'
    autoload :CreditMemoItemList,        'netsuite/records/credit_memo_item_list'
    autoload :CustomField,               'netsuite/records/custom_field'
    autoload :CustomFieldList,           'netsuite/records/custom_field_list'
    autoload :CustomRecord,              'netsuite/records/custom_record'
    autoload :CustomRecordRef,           'netsuite/records/custom_record_ref'
    autoload :CustomRecordType,          'netsuite/records/custom_record_type'
    autoload :Customer,                  'netsuite/records/customer'
    autoload :CustomerAddressbook,       'netsuite/records/customer_addressbook'
    autoload :CustomerAddressbookList,   'netsuite/records/customer_addressbook_list'
    autoload :CustomerPayment,           'netsuite/records/customer_payment'
    autoload :CustomerRefund,            'netsuite/records/customer_refund'
    autoload :CustomerRefundApply,       'netsuite/records/customer_refund_apply'
    autoload :CustomerRefundApplyList,   'netsuite/records/customer_refund_apply_list'
    autoload :CustomerRefundDeposit,     'netsuite/records/customer_refund_deposit'
    autoload :CustomerRefundDepositList, 'netsuite/records/customer_refund_deposit_list'
    autoload :Duration,                  'netsuite/records/duration'
    autoload :InventoryItem,             'netsuite/records/inventory_item'
    autoload :Invoice,                   'netsuite/records/invoice'
    autoload :InvoiceItem,               'netsuite/records/invoice_item'
    autoload :InvoiceItemList,           'netsuite/records/invoice_item_list'
    autoload :Job,                       'netsuite/records/job'
    autoload :JournalEntry,              'netsuite/records/journal_entry'
    autoload :JournalEntryLine,          'netsuite/records/journal_entry_line'
    autoload :JournalEntryLineList,      'netsuite/records/journal_entry_line_list'
    autoload :Location,                  'netsuite/records/location'
    autoload :NonInventorySaleItem,      'netsuite/records/non_inventory_sale_item'
    autoload :PaymentMethod,             'netsuite/records/payment_method'
    autoload :RecordRef,               'netsuite/records/record_ref'
    autoload :ShipAddress,             'netsuite/records/ship_address'
  end

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
    Savon.configure do |config|
      config.logger = NetSuite::XmlLogger.new(STDOUT)
    end
  end

end
