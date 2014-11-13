module NetSuite
  module Records
    class CashSaleItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :amount_ordered, :bin_numbers, :cost_estimate, :current_percent, :defer_rev_rec, :description, :exclude_from_rate_request,
        :gift_cert_from, :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email, :gift_cert_recipient_name, :gross_amt, :is_taxable,
        :item_is_fulfilled, :license_code, :line, :order_line, :percent_complete, :quantity, :quantity_available, :quantity_fulfilled, :quantity_oh_hand,
        :quantity_ordered, :quantity_remaining, :rate, :rev_rec_end_date, :rev_rec_start_date, :serial_numbers, :ship_group, 
        :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_is_estimate, :vsoe_delivered, :vsoe_price

      #field :charges_list,         RecordRefList
      #field :cost_estimate_type,   ItemCostEstimateType
      #field :vsoe_deferral,        VsoeDeferral
      #field :vsoe_permit_discount, VsoePermitDiscount
      #field :vsoe_sop_group,       VsoeSopGroup
      field :custom_field_list,    CustomFieldList
      field :inventory_detail,     InventoryDetail
      field :options,              CustomFieldList

      record_refs :charge_type, :department, :item, :job, :klass, :location, :price, :rev_rec_schedule, :ship_address, :ship_method, :tax_code, :units

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
