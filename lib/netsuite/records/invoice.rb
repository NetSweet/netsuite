module NetSuite
  module Records
    class Invoice
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/invoice.html?mode=package

      actions :get, :get_list, :initialize, :add, :update, :delete, :upsert, :search

      fields :balance, :bill_address,
        :billing_schedule, :contrib_pct, :created_date, :currency_name, :custom_field_list,
        :deferred_revenue, :discount_amount, :discount_date, :discount_item, :discount_rate,
        :due_date, :email, :end_date, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
        :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
        :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
        :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_redemption_list, :handling_tax_1_rate,
        :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
        :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
        :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :item_list, :job, :last_modified_date,
        :linked_tracking_numbers, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
        :other_ref_num, :partners_list, :rev_rec_end_date,
        :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
        :sales_group, :sales_team_list, :ship_address, :ship_date, :ship_group_list,
        :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
        :status, :sync_partner_teams, :sync_sales_teams, :tax_2_total,
        :tax_total, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
        :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
        :to_be_printed, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
        :transaction_bill_address, :transaction_ship_address, :vat_reg_num, :vsoe_auto_calc, :tax_rate

      field :transaction_bill_address, BillAddress
      field :transaction_ship_address, ShipAddress
      field :item_list,                InvoiceItemList
      field :custom_field_list,        CustomFieldList
      field :shipping_address,         Address
      field :billing_address,          Address

      read_only_fields :sub_total, :discount_total, :total, :recognized_revenue, :amount_remaining, :amount_paid,
                       :alt_shipping_cost, :gift_cert_applied, :handling_cost, :alt_handling_cost

      record_refs :account, :bill_address_list, :custom_form, :department, :entity, :klass, :partner,
                  :posting_period, :ship_address_list, :terms, :location, :sales_rep, :tax_item, :created_from,
                  :ship_method, :lead_source, :promo_code, :subsidiary, :currency, :approval_status

      attr_reader   :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

      def self.search_class_name
        "Transaction"
      end

    end
  end
end
