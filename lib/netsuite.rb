require 'set'

require 'savon'
require 'netsuite/version'
require 'netsuite/errors'
require 'netsuite/utilities'
require 'netsuite/utilities/data_center'
require 'netsuite/rest/utilities/roles'
require 'netsuite/rest/utilities/request'
require 'netsuite/core_ext/string/lower_camelcase'

module NetSuite
  autoload :Configuration, 'netsuite/configuration'
  autoload :Response,      'netsuite/response'

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
    autoload :TranEmp,        'netsuite/namespaces/tran_emp'
    autoload :TranGeneral,    'netsuite/namespaces/tran_general'
    autoload :CommGeneral,    'netsuite/namespaces/comm_general'
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
    autoload :DeleteList,       'netsuite/actions/delete_list'
    autoload :Get,              'netsuite/actions/get'
    autoload :GetDeleted,       'netsuite/actions/get_deleted'
    autoload :GetAll,           'netsuite/actions/get_all'
    autoload :GetList,          'netsuite/actions/get_list'
    autoload :GetSelectValue,   'netsuite/actions/get_select_value'
    autoload :Initialize,       'netsuite/actions/initialize'
    autoload :Update,           'netsuite/actions/update'
    autoload :UpdateList,       'netsuite/actions/update_list'
    autoload :Upsert,           'netsuite/actions/upsert'
    autoload :UpsertList,       'netsuite/actions/upsert_list'
    autoload :Search,           'netsuite/actions/search'
    autoload :Login,            'netsuite/actions/login'
  end

  module Records
    autoload :AssemblyItem,                     'netsuite/records/assembly_item'
    autoload :AssemblyBuild,                    'netsuite/records/assembly_build'
    autoload :AssemblyComponent,                'netsuite/records/assembly_component'
    autoload :AssemblyComponentList,            'netsuite/records/assembly_component_list'
    autoload :AssemblyUnbuild,                  'netsuite/records/assembly_unbuild'
    autoload :Account,                          'netsuite/records/account'
    autoload :AccountingPeriod,                 'netsuite/records/accounting_period'
    autoload :Address,                          'netsuite/records/address'
    autoload :BaseRefList,                      'netsuite/records/base_ref_list'
    autoload :BillAddress,                      'netsuite/records/bill_address'
    autoload :BillingSchedule,                  'netsuite/records/billing_schedule'
    autoload :BillingScheduleMilestone,         'netsuite/records/billing_schedule_milestone'
    autoload :BillingScheduleMilestoneList,     'netsuite/records/billing_schedule_milestone_list'
    autoload :BillingScheduleRecurrence,        'netsuite/records/billing_schedule_recurrence'
    autoload :BillingScheduleRecurrenceList,    'netsuite/records/billing_schedule_recurrence_list'
    autoload :Bin,                              'netsuite/records/bin'
    autoload :BinNumber,                        'netsuite/records/bin_number'
    autoload :BinNumberList,                    'netsuite/records/bin_number_list'
    autoload :BinTransfer,                      'netsuite/records/bin_transfer'
    autoload :BinTransferInventory,             'netsuite/records/bin_transfer_inventory'
    autoload :BinTransferInventoryList,         'netsuite/records/bin_transfer_inventory_list'
    autoload :CashSale,                         'netsuite/records/cash_sale'
    autoload :CashSaleItem,                     'netsuite/records/cash_sale_item'
    autoload :CashSaleItemList,                 'netsuite/records/cash_sale_item_list'
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
    autoload :CustomerCategory,                 'netsuite/records/customer_category'
    autoload :CustomerCreditCards,              'netsuite/records/customer_credit_cards'
    autoload :CustomerCreditCardsList,          'netsuite/records/customer_credit_cards_list'
    autoload :CustomerCurrency,                 'netsuite/records/customer_currency'
    autoload :CustomerCurrencyList,             'netsuite/records/customer_currency_list'
    autoload :CustomerDeposit,                  'netsuite/records/customer_deposit'
    autoload :CustomerDepositApplyList,         'netsuite/records/customer_deposit_apply_list'
    autoload :CustomerDepositApply,             'netsuite/records/customer_deposit_apply'
    autoload :CustomerPartnersList,             'netsuite/records/customer_partners_list'
    autoload :CustomerPayment,                  'netsuite/records/customer_payment'
    autoload :CustomerPaymentApply,             'netsuite/records/customer_payment_apply'
    autoload :CustomerPaymentApplyList,         'netsuite/records/customer_payment_apply_list'
    autoload :CustomerPartner,                  'netsuite/records/customer_partner'
    autoload :CustomerRefund,                   'netsuite/records/customer_refund'
    autoload :CustomerRefundApply,              'netsuite/records/customer_refund_apply'
    autoload :CustomerRefundApplyList,          'netsuite/records/customer_refund_apply_list'
    autoload :CustomerRefundDeposit,            'netsuite/records/customer_refund_deposit'
    autoload :CustomerRefundDepositList,        'netsuite/records/customer_refund_deposit_list'
    autoload :CustomerSubscription,             'netsuite/records/customer_subscription'
    autoload :CustomerSubscriptionsList,        'netsuite/records/customer_subscriptions_list'
    autoload :CustomerStatus,                   'netsuite/records/customer_status'
    autoload :CustomerPartner,                  'netsuite/records/customer_partner'
    autoload :CustomerSalesTeam,                'netsuite/records/customer_sales_team'
    autoload :CustomerSalesTeamList,            'netsuite/records/customer_sales_team_list'
    autoload :ContactList,                      'netsuite/records/contact_list'
    autoload :Contact,                          'netsuite/records/contact'
    autoload :ContactAddressbook,               'netsuite/records/contact_addressbook'
    autoload :ContactAddressbookList,           'netsuite/records/contact_addressbook_list'
    autoload :ContactRole,                      'netsuite/records/contact_role'
    autoload :ContactAccessRoles,               'netsuite/records/contact_access_roles'
    autoload :ContactAccessRolesList,           'netsuite/records/contact_access_roles_list'
    autoload :Currency,                         'netsuite/records/currency'
    autoload :CurrencyRate,                     'netsuite/records/currency_rate'
    autoload :Department,                       'netsuite/records/department'
    autoload :Deposit,                          'netsuite/records/deposit'
    autoload :DepositApplication,               'netsuite/records/deposit_application'
    autoload :DepositPayment,                   'netsuite/records/deposit_payment'
    autoload :DepositPaymentList,               'netsuite/records/deposit_payment_list'
    autoload :DepositOther,                     'netsuite/records/deposit_other'
    autoload :DepositOtherList,                 'netsuite/records/deposit_other_list'
    autoload :DepositCashBack,                  'netsuite/records/deposit_cash_back'
    autoload :DepositCashBackList,              'netsuite/records/deposit_cash_back_list'
    autoload :DescriptionItem,                  'netsuite/records/description_item'
    autoload :DiscountItem,                     'netsuite/records/discount_item'
    autoload :Duration,                         'netsuite/records/duration'
    autoload :Employee,                         'netsuite/records/employee'
    autoload :EntityCustomField,                'netsuite/records/entity_custom_field'
    autoload :File,                             'netsuite/records/file'
    autoload :GiftCertificate,                  'netsuite/records/gift_certificate'
    autoload :GiftCertificateItem,              'netsuite/records/gift_certificate_item'
    autoload :GiftCertRedemption,               'netsuite/records/gift_cert_redemption'
    autoload :GiftCertRedemptionList,           'netsuite/records/gift_cert_redemption_list'
    autoload :Folder,                           'netsuite/records/folder'
    autoload :InboundShipment,                  'netsuite/records/inbound_shipment'
    autoload :InboundShipmentItem,              'netsuite/records/inbound_shipment_item'
    autoload :InboundShipmentItemList,          'netsuite/records/inbound_shipment_item_list'
    autoload :InterCompanyJournalEntry,         'netsuite/records/inter_company_journal_entry'
    autoload :InterCompanyJournalEntryLine,     'netsuite/records/inter_company_journal_entry_line'
    autoload :InterCompanyJournalEntryLineList, 'netsuite/records/inter_company_journal_entry_line_list'
    autoload :InventoryAdjustment,              'netsuite/records/inventory_adjustment'
    autoload :InventoryAdjustmentInventory,     'netsuite/records/inventory_adjustment_inventory'
    autoload :InventoryAdjustmentInventoryList, 'netsuite/records/inventory_adjustment_inventory_list'
    autoload :InventoryAssignment,              'netsuite/records/inventory_assignment'
    autoload :InventoryAssignmentList,          'netsuite/records/inventory_assignment_list'
    autoload :InventoryDetail,                  'netsuite/records/inventory_detail'
    autoload :InventoryItem,                    'netsuite/records/inventory_item'
    autoload :InventoryNumber,                  'netsuite/records/inventory_number'
    autoload :InventoryNumberLocations,         'netsuite/records/inventory_number_locations'
    autoload :InventoryNumberLocationsList,     'netsuite/records/inventory_number_locations_list'
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
    autoload :ItemGroup,                        'netsuite/records/item_group'
    autoload :ItemMember,                       'netsuite/records/item_member'
    autoload :ItemMemberList,                   'netsuite/records/item_member_list'
    autoload :ItemReceipt,                      'netsuite/records/item_receipt'
    autoload :ItemReceiptItemList,              'netsuite/records/item_receipt_item_list'
    autoload :ItemReceiptItem,                  'netsuite/records/item_receipt_item'
    autoload :ItemVendor,                       'netsuite/records/item_vendor'
    autoload :ItemVendorList,                   'netsuite/records/item_vendor_list'
    autoload :Job,                              'netsuite/records/job'
    autoload :JobStatus,                        'netsuite/records/job_status'
    autoload :JournalEntry,                     'netsuite/records/journal_entry'
    autoload :JournalEntryLine,                 'netsuite/records/journal_entry_line'
    autoload :JournalEntryLineList,             'netsuite/records/journal_entry_line_list'
    autoload :KitItem,                          'netsuite/records/kit_item'
    autoload :Location,                         'netsuite/records/location'
    autoload :LocationsList,                    'netsuite/records/locations_list'
    autoload :LotNumberedAssemblyItem,          'netsuite/records/lot_numbered_assembly_item'
    autoload :LotNumberedInventoryItem,         'netsuite/records/lot_numbered_inventory_item'
    autoload :MatrixOptionList,                 'netsuite/records/matrix_option_list'
    autoload :MemberList,                       'netsuite/records/member_list'
    autoload :Message,                          'netsuite/records/message'
    autoload :NonInventorySaleItem,             'netsuite/records/non_inventory_sale_item'
    autoload :NonInventoryPurchaseItem,         'netsuite/records/non_inventory_purchase_item'
    autoload :NonInventoryResaleItem,           'netsuite/records/non_inventory_resale_item'
    autoload :Note,                             'netsuite/records/note'
    autoload :NoteType,                         'netsuite/records/note_type'
    autoload :Opportunity,                      'netsuite/records/opportunity'
    autoload :OpportunityItem,                  'netsuite/records/opportunity_item'
    autoload :OpportunityItemList,              'netsuite/records/opportunity_item_list'
    autoload :OtherChargeSaleItem,              'netsuite/records/other_charge_sale_item'
    autoload :Partner,                          'netsuite/records/partner'
    autoload :PaymentItem,                      'netsuite/records/payment_item'
    autoload :PaymentMethod,                    'netsuite/records/payment_method'
    autoload :PayrollItem,                      'netsuite/records/payroll_item'
    autoload :PhoneCall,                        'netsuite/records/phone_call'
    autoload :Price,                            'netsuite/records/price'
    autoload :PriceLevel,                       'netsuite/records/price_level'
    autoload :PriceList,                        'netsuite/records/price_list'
    autoload :Pricing,                          'netsuite/records/pricing'
    autoload :PricingMatrix,                    'netsuite/records/pricing_matrix'
    autoload :PromotionCode,                    'netsuite/records/promotion_code'
    autoload :PromotionsList,                   'netsuite/records/promotions_list'
    autoload :Promotions,                       'netsuite/records/promotions'
    autoload :PurchaseOrder,                    'netsuite/records/purchase_order'
    autoload :PurchaseOrderItemList,            'netsuite/records/purchase_order_item_list'
    autoload :PurchaseOrderItem,                'netsuite/records/purchase_order_item'
    autoload :Roles,                            'netsuite/records/roles'
    autoload :RecordRef,                        'netsuite/records/record_ref'
    autoload :RecordRefList,                    'netsuite/records/record_ref_list'
    autoload :RevRecTemplate,                   'netsuite/records/rev_rec_template'
    autoload :RevRecSchedule,                   'netsuite/records/rev_rec_schedule'
    autoload :RoleList,                         'netsuite/records/role_list'
    autoload :ReturnAuthorization,              'netsuite/records/return_authorization'
    autoload :ReturnAuthorizationItem,          'netsuite/records/return_authorization_item'
    autoload :ReturnAuthorizationItemList,      'netsuite/records/return_authorization_item_list'
    autoload :SalesOrder,                       'netsuite/records/sales_order'
    autoload :SalesOrderShipGroupList,          'netsuite/records/sales_order_ship_group_list'
    autoload :SalesOrderItem,                   'netsuite/records/sales_order_item'
    autoload :SalesOrderItemList,               'netsuite/records/sales_order_item_list'
    autoload :SalesRole,                        'netsuite/records/sales_role'
    autoload :SalesTaxItem,                     'netsuite/records/sales_tax_item'
    autoload :ServiceResaleItem,                'netsuite/records/service_resale_item'
    autoload :ServiceSaleItem,                  'netsuite/records/service_sale_item'
    autoload :SerializedAssemblyItem,          'netsuite/records/serialized_assembly_item'
    autoload :SerializedInventoryItem,          'netsuite/records/serialized_inventory_item'
    autoload :SerializedInventoryItemNumbers,       'netsuite/records/serialized_inventory_item_numbers'
    autoload :SerializedInventoryItemNumbersList,   'netsuite/records/serialized_inventory_item_numbers_list'
    autoload :SerializedInventoryItemLocation,       'netsuite/records/serialized_inventory_item_location'
    autoload :SerializedInventoryItemLocationsList,       'netsuite/records/serialized_inventory_item_locations_list'
    autoload :ShipAddress,                      'netsuite/records/ship_address'
    autoload :SiteCategory,                     'netsuite/records/site_category'
    autoload :Solution,                         'netsuite/records/solution'
    autoload :Subsidiary,                       'netsuite/records/subsidiary'
    autoload :SubtotalItem,                     'netsuite/records/subtotal_item'
    autoload :SupportCase,                      'netsuite/records/support_case'
    autoload :SupportCaseType,                  'netsuite/records/support_case_type'
    autoload :TaxType,                          'netsuite/records/tax_type'
    autoload :TaxGroup,                         'netsuite/records/tax_group'
    autoload :Task,                             'netsuite/records/task'
    autoload :Term,                             'netsuite/records/term'
    autoload :TimeBill,                         'netsuite/records/time_bill'
    autoload :TransactionBodyCustomField,       'netsuite/records/transaction_body_custom_field'
    autoload :TransactionColumnCustomField,     'netsuite/records/transaction_column_custom_field'
    autoload :TransactionShipGroup,             'netsuite/records/transaction_ship_group'
    autoload :TransferOrder,                    'netsuite/records/transfer_order'
    autoload :TransferOrderItemList,            'netsuite/records/transfer_order_item_list'
    autoload :TransferOrderItem,                'netsuite/records/transfer_order_item'
    autoload :UnitsType,                        'netsuite/records/units_type'
    autoload :UnitsTypeUomList,                 'netsuite/records/units_type_uom_list'
    autoload :UnitsTypeUom,                     'netsuite/records/units_type_uom'
    autoload :Vendor,                           'netsuite/records/vendor'
    autoload :VendorBill,                       'netsuite/records/vendor_bill'
    autoload :VendorBillExpense,                'netsuite/records/vendor_bill_expense'
    autoload :VendorBillExpenseList,            'netsuite/records/vendor_bill_expense_list'
    autoload :VendorBillItem,                   'netsuite/records/vendor_bill_item'
    autoload :VendorBillItemList,               'netsuite/records/vendor_bill_item_list'
    autoload :VendorCategory,                   'netsuite/records/vendor_category'
    autoload :VendorCredit,                     'netsuite/records/vendor_credit'
    autoload :VendorCreditApply,                'netsuite/records/vendor_credit_apply'
    autoload :VendorCreditApplyList,            'netsuite/records/vendor_credit_apply_list'
    autoload :VendorCreditItem,                 'netsuite/records/vendor_credit_item'
    autoload :VendorCreditItemList,             'netsuite/records/vendor_credit_item_list'
    autoload :VendorCreditExpense,              'netsuite/records/vendor_credit_expense'
    autoload :VendorCreditExpenseList,          'netsuite/records/vendor_credit_expense_list'
    autoload :VendorReturnAuthorization,        'netsuite/records/vendor_return_authorization'
    autoload :VendorReturnAuthorizationItem,    'netsuite/records/vendor_return_authorization_item'
    autoload :VendorReturnAuthorizationItemList, 'netsuite/records/vendor_return_authorization_item_list'
    autoload :VendorPayment,                    'netsuite/records/vendor_payment'
    autoload :VendorPaymentApply,               'netsuite/records/vendor_payment_apply'
    autoload :VendorPaymentApplyList,           'netsuite/records/vendor_payment_apply_list'
    autoload :WorkOrder,                        'netsuite/records/work_order'
    autoload :WorkOrderItem,                    'netsuite/records/work_order_item'
    autoload :WorkOrderItemList,                'netsuite/records/work_order_item_list'
  end

  module Passports
    autoload :User,  'netsuite/passports/user'
    autoload :Token, 'netsuite/passports/token'
  end

  def self.configure(&block)
    NetSuite::Configuration.instance_eval(&block)
  end

end
