module NetSuite
  module Records
    class SalesOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :auto_apply, :balance,
        :bill_address, :contrib_pct, :created_date, :currency_name, :deferred_revenue, :discount_rate, :email, :end_date,
        :est_gross_profit, :est_gross_profit_percent, :exchange_rate, :exclude_commission, :fax, :gift_cert_applied,
        :gift_cert_available, :gift_cert_total, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :is_taxable,
        :last_modified_date, :memo, :message, :on_credit_hold, :order_status, :other_ref_num, :recognized_revenue,
        :rev_rec_on_rev_commitment, :sales_effective_date, :shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :source,
        :start_date, :status, :sync_partner_teams, :sync_sales_teams, :tax2_total, :tax_rate, :to_be_emailed, :to_be_faxed,
        :to_be_printed, :total_cost_estimate, :tran_date, :tran_id, :tran_is_vsoe_bundle, :vat_reg_num,
        :vsoe_auto_calc

      field :transaction_ship_address, ShipAddress
      field :transaction_bill_address, BillAddress
      field :item_list,                SalesOrderItemList
      field :custom_field_list,        CustomFieldList

      read_only_fields :applied, :discount_total, :sub_total, :tax_total, :total, :unapplied

      record_refs :account, :bill_address_list, :created_from, :currency, :custom_form, :department, :discount_item, :entity, :gift_cert,
        :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel, :opportunity, :partner, :posting_period, :promo_code,
        :sales_group, :sales_rep, :ship_method, :shipping_tax_code, :subsidiary, :terms, :tax_item, :payment_method

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
