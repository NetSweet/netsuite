module NetSuite
  module Records
    class CashRefund
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      actions :get, :add, :initialize, :delete, :update, :upsert, :search

      fields :alt_handling_cost,
        :alt_shipping_cost,
        :cc_approved,
        :cc_expire_date,
        :cc_is_purchase_card_bin,
        :cc_name,
        :cc_number,
        :cc_process_as_purchase_card,
        :cc_street,
        :cc_zip_code,
        :charge_it,
        :contrib_pct,
        :created_date,
        :currency_name,
        :debit_card_issue_no,
        :deferred_revenue,
        :discount_rate,
        :discount_total,
        :email,
        :est_gross_profit,
        :est_gross_profit_percent,
        :exchange_rate,
        :exclude_commission,
        :fax,
        :gift_cert_applied,
        :gift_cert_available,
        :gift_cert_total,
        :handling_cost,
        :handling_tax1_rate,
        :handling_tax2_rate,
        :is_taxable,
        :last_modified_date,
        :memo,
        :message,
        :other_ref_num,
        :pay_pal_auth_id,
        :pay_pal_process,
        :pay_pal_status,
        :pay_pal_tran_id,
        :pn_ref_num,
        :recognized_revenue,
        :refund_check,
        :rev_rec_on_rev_commitment,
        :sales_effective_date,
        :shipping_cost,
        :shipping_tax1_rate,
        :shipping_tax2_rate,
        :source,
        :status,
        :sub_total,
        :sync_partner_teams,
        :sync_sales_teams,
        :tax2_total,
        :tax_rate,
        :tax_total,
        :to_be_emailed,
        :to_be_faxed,
        :to_be_printed,
        :to_print2,
        :total,
        :total_cost_estimate,
        :tran_date,
        :tran_id,
        :tran_is_vsoe_bundle,
        :valid_from,
        :vat_reg_num,
        :vsoe_auto_calc

      # NOTE only `Address` record in >= 2014_2
      field :billing_address, Address

      field :item_list, CashRefundItemList
      field :custom_field_list, CustomFieldList
      # partnersList	CashRefundPartnersList
      # salesTeamList	CashRefundSalesTeamList

      record_refs :account,
        :bill_address_list,
        :klass,
        :created_from,
        :credit_card,
        :credit_card_processor,
        :currency,
        :custom_form,
        :department,
        :discount_item,
        :entity,
        :gift_cert,
        :handling_tax_code,
        :job,
        :lead_source,
        :location,
        :message_sel,
        :partner,
        :payment_method,
        :posting_period,
        :promo_code,
        :sales_group,
        :sales_rep,
        :ship_method,
        :shipping_tax_code,
        :subsidiary,
        :tax_item

      attr_reader :internal_id
      attr_accessor :external_id

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
