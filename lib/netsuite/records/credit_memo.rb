module NetSuite
  module Records
    class CreditMemo
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :auto_apply, :balance,
        :bill_address, :contrib_pct, :created_date, :currency_name, :deferred_revenue, :discount_rate, :email,
        :est_gross_profit, :est_gross_profit_percent, :exchange_rate, :exclude_commission, :fax, :gift_cert_applied,
        :gift_cert_available, :gift_cert_total, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :is_taxable,
        :last_modified_date, :memo, :message, :on_credit_hold, :other_ref_num, :recognized_revenue, :rev_rec_on_rev_commitment,
        :sales_effective_date, :shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :source, :status,
        :sync_partner_teams, :sync_sales_teams, :tax2_total, :tax_rate, :to_be_emailed, :to_be_faxed,
        :to_be_printed, :total_cost_estimate, :tran_date, :tran_id, :tran_is_vsoe_bundle, :vat_reg_num,
        :vsoe_auto_calc

      read_only_fields :applied, :discount_total, :sub_total, :tax_total, :total, :unapplied

      record_refs :account, :bill_address_list, :created_from, :custom_form, :department, :discount_item, :entity, :gift_cert,
        :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel, :partner, :posting_period, :promo_code,
        :sales_group, :sales_rep, :ship_method, :shipping_tax_code, :subsidiary, :tax_item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def self.get(options = {})
        response = Actions::Get.call(self, options)
        if response.success?
          new(response.body)
        else
          raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
        end
      end

      def self.initialize(object)
        response = Actions::Initialize.call(self, object)
        if response.success?
          new(response.body)
        else
          raise InitializationError, "#{self}.initialize with #{object} failed."
        end
      end

      def add
        response = Actions::Add.call(self)
        response.success?
      end

    end
  end
end
