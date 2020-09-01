module NetSuite
  module Records
    class Estimate
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :alt_handling_cost, :alt_sales_total, :alt_shipping_cost, :balance,
        :bill_address, :billing_address, :billing_schedule, :bill_is_residential,
        :created_date, :currency_name, :discount_rate, :email, :end_date,
        :est_gross_profit, :exchange_rate, :handling_cost, :handling_tax1_rate, :is_taxable,
        :last_modified_date, :memo, :message, :other_ref_num, :ship_date, :shipping_cost, 
        :shipping_tax1_rate, :source, :start_date, :status, :sync_partner_teams, :sync_sales_teams, 
        :to_be_emailed, :to_be_faxed, :to_be_printed, :total_cost_estimate, :tran_date, :tran_id, 
        :linked_tracking_numbers, :is_multi_ship_to

      field :shipping_address, Address
      field :billing_address, Address

      field :item_list,                   EstimateItemList
      field :custom_field_list,           CustomFieldList

      record_refs :bill_address_list, :created_from, :currency, :custom_form, :department, :discount_item, :entity, 
        :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel, :opportunity, :partner, 
        :promo_code, :sales_group, :sales_rep, :ship_method, :shipping_tax_code, :subsidiary, :terms

      attr_reader :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
