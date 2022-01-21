module NetSuite
  module Records
    class Opportunity
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :action_item, :alt_sales_range_high, :alt_sales_range_low,
        :close_date, :contrib_pct, :created_date, :currency_name, :days_open,
        :estimated_budget, :est_gross_profit, :est_gross_profit_percent,
        :exchange_rate, :expected_close_date,
        :is_budget_approved, :last_modified_date,
        :memo, :probability, :proj_alt_sales_amt, :projected_total,
        :range_high, :range_low,
        :ship_is_residential, :source, :status, :sync_partner_teams, :sync_sales_teams,
        :tax2_total, :title, :total_cost_estimate, :tran_date, :tran_id,
        :vat_reg_num, :weighted_total

      field :ship_address, ShipAddress
      field :bill_address, BillAddress
      field :item_list,                OpportunityItemList
      field :custom_field_list,        CustomFieldList

      read_only_fields :discount_total, :sub_total, :tax_total, :total

      record_refs :account, :buying_reason, :currency, :klass, :department, :entity, :entity_status, :location,
        :partner, :subsidiary, :sales_group, :sales_rep, :custom_form, :job, :forcast_type,
        :lead_source, :sales_readiness, :win_loss_reason

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
