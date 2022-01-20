module NetSuite
  module Records
    class Estimate
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :alt_handling_cost,
             :alt_sales_total,
             :alt_shipping_cost,
             :can_have_stackable,
             :contrib_pct,
             :created_date,
             :currency_name,
             :discount_rate,
             :discount_total,
             :due_date,
             :email,
             :end_date,
             :est_gross_profit,
             :est_gross_profit_percent,
             :exchange_rate,
             :expected_close_date,
             :fax,
             :fob,
             :handling_cost,
             :handling_tax1_rate,
             :handling_tax2_rate,
             :include_in_forecast,
             :is_taxable,
             :last_modified_date,
             :linked_tracking_numbers,
             :memo,
             :message,
             :one_time,
             :other_ref_num,
             :probability,
             :recur_annually,
             :recur_monthly,
             :recur_quarterly,
             :recur_weekly,
             :ship_date,
             :ship_is_residential,
             :shipping_cost,
             :shipping_tax1_rate,
             :shipping_tax2_rate,
             :source,
             :start_date,
             :status,
             :sub_total,
             :sync_partner_teams,
             :sync_sales_teams,
             :tax2_total,
             :tax_details_override,
             :tax_point_date,
             :tax_rate,
             :tax_reg_override,
             :tax_total,
             :title,
             :to_be_emailed,
             :to_be_faxed,
             :to_be_printed,
             :total,
             :total_cost_estimate,
             :tracking_numbers,
             :tran_date,
             :tran_id,
             :vat_reg_num,
             :visible_to_customer

      field :billing_address, Address
      field :custom_field_list,           CustomFieldList
      field :item_list, EstimateItemList
      field :promotions_list, PromotionsList
      field :shipping_address, Address

      record_refs :bill_address_list,
                  :billing_schedule,
                  :klass,
                  :created_from,
                  :currency,
                  :custom_form,
                  :department,
                  :discount_item,
                  :entity,
                  :entity_status,
                  :entity_tax_reg_num,
                  :forecast_type,
                  :handling_tax_code,
                  :job,
                  :lead_source,
                  :location,
                  :message_sel,
                  :nexus,
                  :opportunity,
                  :partner,
                  :promo_code,
                  :sales_group,
                  :sales_rep,
                  :ship_address_list,
                  :ship_method,
                  :shipping_tax_code,
                  :subsidiary,
                  :subsidiary_tax_reg_num,
                  :tax_item,
                  :terms

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
