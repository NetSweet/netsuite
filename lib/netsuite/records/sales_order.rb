module NetSuite
  module Records
    class SalesOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :add, :update, :delete

      fields :created_date, :tran_date, :tran_id, :source, :orderStatus, :contrib_pct,
        :sync_sales_teams, :start_date, :end_date, :other_ref_num, :memo, :sales_effective_date,
          :exclude_commission, :total_cost_estimate, :est_gross_profit, :est_gross_profit_percent,
          :exchange_rate, :currency_name, :dicount_rate, :is_taxable, :tax_rate, :to_be_printed,
          :to_be_emailed, :email, :to_be_faxed, :fax, :message, :transaction_bill_address,
          :billAddress, :fob, :ship_date, :actual_ship_date, :shipping_cost, :shipping_tax1_rate,
          :is_multi_ship_to, :shipping_tax2_rate, :handling_tax1_rate,
          :handling_tax2_rate, :handling_cost, :tracking_numbers, :linked_tracking_numbers,
          :ship_complete, :shopper_ip_address, :save_on_auth_decline, :revenue_status,
          :recognized_revenue, :deferred_revenue, :rev_rec_on_rev_commitment,
          :rev_commit_status, :cc_number, :cc_expire_date, :cc_name, :cc_street,
          :cc_zip_code, :pay_pal_status, :pay_pal_tran_id, :cc_approved, :get_auth,
          :auth_code, :cc_avs_street_match, :cc_avs_zip_match, :cc_security_code_match,
          :all_sales_total, :ignore_avs, :payment_event_result,:payment_event_hold_reason,
          :payment_event_type, :payment_event_date, :payment_event_updated_by,
          :sub_total, :discount_total, :tax_total, :alt_shipping_cost, :alt_handling_cost,
          :total, :rev_rec_start_date, :rev_rec_end_date, :paypal_process, :three_d_status_code,
          :interco_status, :debit_card_issue_no, :last_modified_date, :pn_ref_number, :status,
          :tax2_total, :valid_from, :vat_reg_num, :gift_cert_applied, :tran_is_vsoe_bundle,
          :vsoe_auto_calc, :sync_partner_teams, :transaction_ship_address, :klass

      field :custom_field_list, CustomFieldList
      field :item_list, SalesOrderItemList

      record_refs :custom_form, :entity, :job, :currency, :dr_account, :fx_account,
        :created_from, :opportunity, :sales_rep, :partner, :sales_group, :lead_source,
        :promo_code, :discount_item, :tax_item, :message_sel, :bill_address_list,
        :ship_method, :shipping_tax_code, :handling_tax_code, :credit_card,
        :credit_card_processor, :rev_rec_schedule, :billing_schedule, :department,
        :subsidiary, :interco_transaction, :location, :terms

      attr_accessor :internal_id
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
