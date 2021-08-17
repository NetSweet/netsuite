module NetSuite
	module Records
    	class ItemFulfillmentItem
    	  include Support::Fields
	      include Support::RecordRefs
	      include Support::Records
	      include Namespaces::TranSales

	      fields :amount, :amount_ordered, :bin_numbers, :cost_estimate, :cost_estimate_type, :current_percent,
	        :defer_rev_rec, :description, :gift_cert_from, :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email,
	        :gift_cert_recipient_name, :gross_amt, :inventory_detail, :is_taxable, :item_is_fulfilled, :license_code, :line,
	        :options, :order_line, :percent_complete, :quantity, :quantity_available, :quantity_fulfilled,
	        :quantity_on_hand, :quantity_ordered, :rate, :rev_rec_end_date, :rev_rec_start_date,
	        :serial_numbers, :ship_group, :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_deferral,
	        :vsoe_delivered, :vsoe_permit_discount, :vsoe_price, :item_receive

	      field :custom_field_list, CustomFieldList

	      read_only_fields :quantity_remaining

	      record_refs :department, :item, :job, :location, :price, :rev_rec_schedule, :ship_address, :ship_method, :tax_code, :units, :klass

	      def initialize(attributes_or_record = {})
	        case attributes_or_record
	        when Hash
	          initialize_from_attributes_hash(attributes_or_record)
	        when self.class
	          initialize_from_record(attributes_or_record)
	        end
	      end

	      def initialize_from_record(record)
	        self.attributes = record.send(:attributes)
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
