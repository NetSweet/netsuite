module NetSuite
  module Records
    class ReturnAuthorization
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2015_2/schema/record/returnauthorization.html

      actions :get, :get_list, :initialize, :add, :update, :delete, :upsert, :search

      fields :alt_sales_total,
        :cc_approved,
        :cc_expire_date,
        :cc_name,
        :cc_number,
        :cc_street,
        :cc_zip_code,
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
        :is_taxable,
        :job,
        :last_modified_date,
        :memo,
        :message,
        :other_ref_num,
        :pay_pal_auth_id,
        :pay_pal_process,
        :pn_ref_num,
        :recognized_revenue,
        :rev_rec_end_date,
        :rev_rec_on_rev_commitment,
        :rev_rec_start_date,
        :sales_effective_date,
        :ship_address,
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
        :total,
        :total_cost_estimate,
        :tran_date,
        :tran_id,
        :tran_is_vsoe_bundle,
        :valid_from,
        :vat_reg_num,
        :vsoe_auto_calc

      record_refs :klass,
        :created_from,
        :credit_card,
        :credit_card_processor,
        :currency,
        :custom_form,
        :department,
        :discount_item,
        :dr_account,
        :entity,
        :fx_account,
        :gift_cert,
        :interco_status,
        :interco_transaction,
        :lead_source,
        :location,
        :message_sel,
        :order_status,
        :partner,
        :payment_method,
        :promo_code,
        :rev_commit_status,
        :revenue_status,
        :rev_rec_schedule,
        :sales_group,
        :sales_rep,
        :subsidiary,
        :tax_item

      # :bill_address_list
      # :item_list,
      # :partners_list,
      # :sales_team_list,
      # :ship_address_list,

      field :billing_address,          Address
      field :shipping_address,         Address
      field :custom_field_list,        CustomFieldList
      field :item_list,                ReturnAuthorizationItemList

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

      def self.search_class_name
        "Transaction"
      end

    end
  end
end
