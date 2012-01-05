module NetSuite
  module Records
    class Invoice
      include FieldSupport
      include RecordSupport

      fields :account, :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :balance, :bill_address,
        :bill_address_list, :billing_schedule, :contrib_pct, :created_date, :created_from, :currency_name, :custom_field_list,
        :custom_form, :deferred_revenue, :department, :discount_amount, :discount_date, :discount_item, :discount_rate,
        :discount_total, :due_date, :email, :end_date, :entity, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
        :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
        :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
        :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_applied, :gift_cert_redemption_list, :handling_cost, :handling_tax_1_rate,
        :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
        :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
        :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :item_list, :job, :klass, :last_modified_date,
        :lead_source, :linked_tracking_numbers, :location, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
        :other_ref_name, :partner, :partners_list, :posting_period, :promo_code, :recognized_revenue, :rev_rec_end_date,
        :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
        :sales_group, :sales_rep, :sales_team_list, :ship_address, :ship_address_list, :ship_date, :ship_group_list,
        :ship_method, :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
        :status, :sub_total, :subsidiary, :sync_partner_teams, :sync_sales_teams, :tax_2_total, :tax_item, :tax_rate,
        :tax_total, :terms, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
        :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
        :to_be_printed, :total, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
        :transaction_bill_address, :transaction_ship_address, :vat_reg_num, :vsoe_auto_calc

      attr_reader :internal_id, :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id)
        @external_id = attributes.delete(:external_id)
        initialize_from_attributes_hash(attributes)
      end

      def account=(attrs)
        attributes[:account] = RecordRef.new(attrs)
      end

      def bill_address_list=(attrs)
        attributes[:bill_address_list] = RecordRef.new(attrs)
      end

      def custom_form=(attrs)
        attributes[:custom_form] = RecordRef.new(attrs)
      end

      def entity=(attrs)
        attributes[:entity] = RecordRef.new(attrs)
      end

      def posting_period=(attrs)
        attributes[:posting_period] = RecordRef.new(attrs)
      end

      def ship_address_list=(attrs)
        attributes[:ship_address_list] = RecordRef.new(attrs)
      end

      def self.initialize(customer)
        response = Actions::Initialize.call(customer)
        if response.success?
          new(response.body)
        else
          raise RecordNotFound, "#{self} with ID=#{id} could not be found"
        end
      end

      def add
        response = Actions::Add.call(self)
        response.success?
      end

    end
  end
end
