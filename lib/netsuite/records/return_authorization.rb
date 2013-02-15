module NetSuite
  module Records
    class ReturnAuthorization
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      actions :get, :add, :update, :delete

      fields :created_date, :last_modified_date, :vat_reg_number, :tran_date, :tran_id, :source,
        :interco_status, :other_ref_num, :memo, :sales_effective_date, :total_cost_estimate,
        :est_gross_profit, :est_gross_profit_percent, :rev_rec_start_date, :rev_rec_end_date,
        :exclude_commission, :exchange_rate, :currency_name, :discount_rate, :tax_rate,
        :to_be_printed, :to_be_emailed, :to_be_faxed, :message, :transaction_bill_address,
        :bill_address, :ship_address, :sync_sales_teams, :revenue_status, :recognized_revenue,
        :deferred_revenue, :rev_rec_on_rev_commitment, :rev_commit_status, :cc_number,
        :alt_sales_total, :cc_expire_date, :cc_name, :cc_street, :cc_zip_code, :cc_approved,
        :pn_ref_num, :sub_total, :discount_total, :total, :pay_pal_auth_id, :pay_pal_process,
        :email, :fax, :debit_card_issue_no, :is_taxable, :status, :tax_total, :tax2_total,
        :valid_from, :order_status, :contrib_pct, :gift_cert_total, :gift_cert_applied,
        :tran_is_vsoe_bundle, :vsoe_auto_calc, :sync_partner_teams

      field :custom_field_list, CustomFieldList
      field :item_list, ReturnAuthorizationItemList

      attr_reader   :internal_id
      attr_accessor :external_id

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

      
    end

  end
end
