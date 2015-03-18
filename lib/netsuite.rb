require 'set'

require 'savon'
require 'netsuite/version'
require 'netsuite/errors'
require 'netsuite/utilities'
require 'netsuite/core_ext/string/lower_camelcase'

module NetSuite
  autoload :Configuration,    'netsuite/configuration'
  autoload :Response,         'netsuite/response'
  autoload :Status,           'netsuite/status'

  module Async
    autoload :Status,             'netsuite/async/status'
    autoload :WriteResponse,      'netsuite/async/write_response'
    autoload :WriteResponseList,  'netsuite/async/write_response_list'
  end

  module Namespaces
    autoload :ActSched,       'netsuite/namespaces/act_sched'
    autoload :FileCabinet,    'netsuite/namespaces/file_cabinet'
    autoload :ListAcct,       'netsuite/namespaces/list_acct'
    autoload :ListRel,        'netsuite/namespaces/list_rel'
    autoload :ListSupport,    'netsuite/namespaces/list_support'
    autoload :ListWebsite,    'netsuite/namespaces/list_website'
    autoload :PlatformCommon, 'netsuite/namespaces/platform_common'
    autoload :PlatformCore,   'netsuite/namespaces/platform_core'
    autoload :TranBank,       'netsuite/namespaces/tran_bank'
    autoload :TranCust,       'netsuite/namespaces/tran_cust'
    autoload :TranGeneral,    'netsuite/namespaces/tran_general'
    autoload :TranInvt,       'netsuite/namespaces/tran_invt'
    autoload :TranSales,      'netsuite/namespaces/tran_sales'
    autoload :TranPurch,      'netsuite/namespaces/tran_purch'
    autoload :SetupCustom,    'netsuite/namespaces/setup_custom'
    autoload :ListEmp,        'netsuite/namespaces/list_emp'
    autoload :ListMkt,        'netsuite/namespaces/list_mkt'
  end

  module Support
    autoload :Actions,    'netsuite/support/actions'
    autoload :Attributes, 'netsuite/support/attributes'
    autoload :Base,       'netsuite/support/base'
    autoload :Fields,     'netsuite/support/fields'
    autoload :Sublist,    'netsuite/support/sublist'
    autoload :RecordRefs, 'netsuite/support/record_refs'
    autoload :Records,    'netsuite/support/records'
    autoload :Requests,   'netsuite/support/requests'
    autoload :SearchResult, 'netsuite/support/search_result'
    autoload :Country,      'netsuite/support/country'
  end

  module Actions
    autoload :Add,              'netsuite/actions/add'
    autoload :Delete,           'netsuite/actions/delete'
    autoload :Get,              'netsuite/actions/get'
    autoload :GetAll,           'netsuite/actions/get_all'
    autoload :GetList,          'netsuite/actions/get_list'
    autoload :GetSelectValue,   'netsuite/actions/get_select_value'
    autoload :Initialize,       'netsuite/actions/initialize'
    autoload :Update,           'netsuite/actions/update'
    autoload :Upsert,           'netsuite/actions/upsert'
    autoload :UpsertList,       'netsuite/actions/upsert_list'
    autoload :Search,           'netsuite/actions/search'
    autoload :Login,            'netsuite/actions/login'
    autoload :AsyncAddList,     'netsuite/actions/async_add_list'
  end

  module Records
    autoload :AssemblyItem,                     'netsuite/records/assembly_item'
    autoload :Account,                          'netsuite/records/account'
    autoload :AccountingPeriod,                 'netsuite/records/accounting_period'
    autoload :BaseRefList,                      'netsuite/records/base_ref_list'
    autoload :BillAddress,                      'netsuite/records/bill_address'
    autoload :BillingSchedule,                  'netsuite/records/billing_schedule'
    autoload :BillingScheduleMilestone,         'netsuite/records/billing_schedule_milestone'
    autoload :BillingScheduleMilestoneList,     'netsuite/records/billing_schedule_milestone_list'
    autoload :BillingScheduleRecurrence,        'netsuite/records/billing_schedule_recurrence'
    autoload :BillingScheduleRecurrenceList,    'netsuite/records/billing_schedule_recurrence_list'
    autoload :BinNumberList,                    'netsuite/records/bin_number_list'
    autoload :CashSale,                         'netsuite/records/cash_sale'
    autoload :CashRefund,                       'netsuite/records/cash_refund'
    autoload :CashRefundItem,                   'netsuite/records/cash_refund_item'
    autoload :CashRefundItemList,               'netsuite/records/cash_refund_item_list'
    autoload :Campaign,                         'netsuite/records/campaign'
    autoload :Classification,                   'netsuite/records/classification'
    autoload :CreditMemo,                       'netsuite/records/credit_memo'
    autoload :CreditMemoApply,                  'netsuite/records/credit_memo_apply'
    autoload :CreditMemoApplyList,              'netsuite/records/credit_memo_apply_list'
    autoload :CreditMemoItem,                   'netsuite/records/credit_memo_item'
    autoload :CreditMemoItemList,               'netsuite/records/credit_memo_item_list'
    autoload :CustomField,                      'netsuite/records/custom_field'
    autoload :CustomFieldList,                  'netsuite/records/custom_field_list'
    autoload :CustomList,                       'netsuite/records/custom_list'
    autoload :CustomRecord,                     'netsuite/records/custom_record'
    autoload :CustomRecordRef,                  'netsuite/records/custom_record_ref'
    autoload :CustomRecordType,                 'netsuite/records/custom_record_type'
    autoload :CustomListCustomValue,            'netsuite/records/custom_list_custom_value'
    autoload :CustomListCustomValueList,        'netsuite/records/custom_list_custom_value_list'
    autoload :Customer,                         'netsuite/records/customer'
    autoload :CustomerAddressbook,              'netsuite/records/customer_addressbook'
    autoload :CustomerAddressbookList,          'netsuite/records/customer_addressbook_list'
    autoload :CustomerDeposit,                  'netsuite/records/customer_deposit'
    autoload :CustomerPayment,                  'netsuite/records/customer_payment'
    autoload :CustomerPaymentApply,             'netsuite/records/customer_payment_apply'
    autoload :CustomerPaymentApplyList,         'netsuite/records/customer_payment_apply_list'
    autoload :CustomerRefund,                   'netsuite/records/customer_refund'
    autoload :CustomerRefundApply,              'netsuite/records/customer_refund_apply'
    autoload :CustomerRefundApplyList,          'netsuite/records/customer_refund_apply_list'
    autoload :CustomerRefundDeposit,            'netsuite/records/customer_refund_deposit'
    autoload :CustomerRefundDepositList,        'netsuite/records/customer_refund_deposit_list'
    autoload :ContactList,                      'netsuite/records/contact_list'
    autoload :Contact,                          'netsuite/records/contact'
    autoload :ContactAccessRoles,               'netsuite/records/contact_access_roles'
    autoload :ContactAccessRolesList,           'netsuite/records/contact_access_roles_list'
    autoload :Department,                       'netsuite/records/department'
    autoload :Deposit,                          'netsuite/records/deposit'
    autoload :DepositPayment,                   'netsuite/records/deposit_payment'
    autoload :DepositPaymentList,               'netsuite/records/deposit_payment_list'
    autoload :DepositOther,                     'netsuite/records/deposit_other'
    autoload :DepositOtherList,                 'netsuite/records/deposit_other_list'
    autoload :DepositCashBack,                  'netsuite/records/deposit_cash_back'
    autoload :DepositCashBackList,              'netsuite/records/deposit_cash_back_list'
    autoload :DiscountItem,                     'netsuite/records/discount_item'
    autoload :Duration,                         'netsuite/records/duration'
    autoload :Employee,                         'netsuite/records/employee'
    autoload :File,                             'netsuite/records/file'
    autoload :InventoryAssignment,              'netsuite/records/inventory_assignment'
    autoload :InventoryAssignmentList,          'netsuite/records/inventory_assignment_list'
    autoload :InventoryDetail,                  'netsuite/records/inventory_detail'
    autoload :InventoryItem,                    'netsuite/records/inventory_item'
    autoload :InventoryTransfer,                'netsuite/records/inventory_transfer'
    autoload :InventoryTransferInventory,       'netsuite/records/inventory_transfer_inventory'
    autoload :InventoryTransferInventoryList,   'netsuite/records/inventory_transfer_inventory_list'
    autoload :Invoice,                          'netsuite/records/invoice'
    autoload :InvoiceItem,                      'netsuite/records/invoice_item'
    autoload :InvoiceItemList,                  'netsuite/records/invoice_item_list'
    autoload :ItemFulfillment,                  'netsuite/records/item_fulfillment'
    autoload :ItemFulfillmentItem,              'netsuite/records/item_fulfillment_item'
    autoload :ItemFulfillmentItemList,          'netsuite/records/item_fulfillment_item_list'
    autoload :ItemFulfillmentPackage,           'netsuite/records/item_fulfillment_package'
    autoload :ItemFulfillmentPackageList,       'netsuite/records/item_fulfillment_package_list'
    autoload :ItemMember,                       'netsuite/records/item_member'
    autoload :Job,                              'netsuite/records/job'
    autoload :JournalEntry,                     'netsuite/records/journal_entry'
    autoload :JournalEntryLine,                 'netsuite/records/journal_entry_line'
    autoload :JournalEntryLineList,             'netsuite/records/journal_entry_line_list'
    autoload :KitItem,                          'netsuite/records/kit_item'
    autoload :Location,                         'netsuite/records/location'
    autoload :LocationsList,                    'netsuite/records/locations_list'
    autoload :MatrixOptionList,                 'netsuite/records/matrix_option_list'
    autoload :MemberList,                       'netsuite/records/member_list'
    autoload :NonInventorySaleItem,             'netsuite/records/non_inventory_sale_item'
    autoload :Partner,                          'netsuite/records/partner'
    autoload :PaymentMethod,                    'netsuite/records/payment_method'
    autoload :PhoneCall,                        'netsuite/records/phone_call'
    autoload :PricingMatrix,                    'netsuite/records/pricing_matrix'
    autoload :PromotionCode,                    'netsuite/records/promotion_code'
    autoload :RecordRef,                        'netsuite/records/record_ref'
    autoload :RecordRefList,                    'netsuite/records/record_ref_list'
    autoload :RevRecTemplate,                   'netsuite/records/rev_rec_template'
    autoload :RoleList,                         'netsuite/records/role_list'
    autoload :SalesOrder,                       'netsuite/records/sales_order'
    autoload :SalesOrderItem,                   'netsuite/records/sales_order_item'
    autoload :SalesOrderItemList,               'netsuite/records/sales_order_item_list'
    autoload :SalesTaxItem,                     'netsuite/records/sales_tax_item'
    autoload :ServiceSaleItem,                  'netsuite/records/service_sale_item'
    autoload :ShipAddress,                      'netsuite/records/ship_address'
    autoload :SiteCategory,                     'netsuite/records/site_category'
    autoload :Subsidiary,                       'netsuite/records/subsidiary'
    autoload :SupportCase,                      'netsuite/records/support_case'
    autoload :TaxType,                          'netsuite/records/tax_type'
    autoload :Task,                             'netsuite/records/task'
    autoload :Term,                             'netsuite/records/term'
    autoload :Transaction,                      'netsuite/records/transaction'
    autoload :UnitsType,                        'netsuite/records/units_type'
    autoload :UnitsTypeUomList,                 'netsuite/records/units_type_uom_list'
    autoload :UnitsTypeUom,                     'netsuite/records/units_type_uom'
    autoload :Vendor,                           'netsuite/records/vendor'
    autoload :VendorBill,                       'netsuite/records/vendor_bill'
    autoload :VendorBillExpense,                'netsuite/records/vendor_bill_expense'
    autoload :VendorBillExpenseList,            'netsuite/records/vendor_bill_expense_list'
    autoload :VendorBillItem,                   'netsuite/records/vendor_bill_item'
    autoload :VendorBillItemList,               'netsuite/records/vendor_bill_item_list'
    autoload :VendorPayment,                    'netsuite/records/vendor_payment'
    autoload :VendorPaymentApply,               'netsuite/records/vendor_payment_apply'
    autoload :VendorPaymentApplyList,           'netsuite/records/vendor_payment_apply_list'
    autoload :WorkOrder,                        'netsuite/records/work_order'
    autoload :WorkOrderItem,                    'netsuite/records/work_order_item'
    autoload :WorkOrderItemList,                'netsuite/records/work_order_item_list'
  end

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

  def self.configure_from_env(&block)
    NetSuite.configure do
      reset!
      
      email         ENV['NETSUITE_EMAIL']     unless ENV['NETSUITE_EMAIL'].nil?
      password      ENV['NETSUITE_PASSWORD']  unless ENV['NETSUITE_PASSWORD'].nil?
      account       ENV['NETSUITE_ACCOUNT']   unless ENV['NETSUITE_ACCOUNT'].nil?
      role          ENV['NETSUITE_ROLE']      unless ENV['NETSUITE_ROLE'].nil?
      api_version   ENV['NETSUITE_API']       unless ENV['NETSUITE_API'].nil?
      sandbox       (ENV['NETSUITE_PRODUCTION'].nil? || ENV['NETSUITE_PRODUCTION'] != 'true')
      wsdl          ENV['NETSUITE_WSDL']      unless ENV['NETSUITE_WSDL'].nil?
      silent        (!ENV['NETSUITE_SILENT'].nil? && ENV['NETSUITE_SILENT'] == 'true')

      read_timeout  100_000
    end

    self.configure(&block) if block
  end

end
