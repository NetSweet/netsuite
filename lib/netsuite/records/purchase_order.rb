module NetSuite
  module Records
    class PurchaseOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :created_date, :currency_name, :due_date, :email, :exchange_rate,
             :fax, :fob, :interco_status, :interco_transaction, :last_modified_date,
             :linked_tracking_numbers, :memo, :message, :other_ref_num, :ship_date,
             :ship_is_residential, :ship_to, :source, :status, :sub_total, :supervisor_approval,
             :tax2_total, :tax_total, :to_be_emailed, :to_be_faxed, :to_be_printed,
             :total, :tracking_numbers, :tran_date, :tran_id, :vat_reg_num

      # NOTE API >= 2014_2 only
      field :billing_address,   Address
      field :shipping_address,  Address
  
      # NOTE transaction address fields only applicable for API < 2014_2
      field :transaction_bill_address,  BillAddress
      field :transaction_ship_address,  ShipAddress

      field :custom_field_list, CustomFieldList
      field :item_list,         PurchaseOrderItemList

      # TODO custom lists
      # :ship_address_list
      # :expense_list

      record_refs :approval_status, :bill_address_list, :klass, :created_from, :currency,
                  :custom_form, :department, :employee, :entity, :interco_transaction, :location, :next_approver,
                  :order_status, :purchase_contract, :ship_method, :ship_to, :subsidiary, :terms

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        'tranSales'
      end

    end
  end
end
