module NetSuite
  module Records
    class Invoice
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/invoice.html?mode=package

      actions :attach_file, :get, :get_deleted, :get_list, :initialize, :add, :update, :delete, :upsert, :upsert_list, :search

      fields :balance,
        :billing_schedule, :contrib_pct, :created_date, :currency_name,
        :deferred_revenue, :discount_amount, :discount_date, :discount_rate,
        :due_date, :email, :end_date, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
        :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
        :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
        :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_redemption_list, :handling_tax_1_rate,
        :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
        :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
        :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :last_modified_date,
        :linked_tracking_numbers, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
        :other_ref_num, :partners_list, :rev_rec_end_date,
        :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
        :sales_group, :sales_team_list, :ship_date, :ship_group_list,
        :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
        :status, :sync_partner_teams, :sync_sales_teams, :tax_2_total,
        :tax_total, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
        :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
        :to_be_printed, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
        :vat_reg_num, :vsoe_auto_calc, :tax_rate

      field :transaction_bill_address, BillAddress
      field :transaction_ship_address, ShipAddress
      field :item_list,                InvoiceItemList
      field :custom_field_list,        CustomFieldList
      field :shipping_address,         Address
      field :billing_address,          Address
      field :null_field_list,          NullFieldList

      read_only_fields :sub_total, :discount_total, :total, :recognized_revenue, :amount_remaining, :amount_paid,
                       :alt_shipping_cost, :gift_cert_applied, :handling_cost, :alt_handling_cost

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2020_2/schema/search/transactionsearchrowbasic.html?mode=package
      search_only_fields :abbrev, :account_type, :acct_corp_card_exp,
        :actual_production_end_date, :actual_production_start_date,
        :actual_ship_date, :alt_sales_amount, :alt_sales_net_amount, :amount,
        :amount_unbilled, :applied_to_foreign_amount,
        :applied_to_is_fx_variance, :applied_to_link_amount,
        :applied_to_link_type, :applied_to_transaction,
        :applying_foreign_amount, :applying_is_fx_variance,
        :applying_link_amount, :applying_link_type, :applying_transaction,
        :auth_code, :auto_calculate_lag, :avs_street_match, :avs_zip_match,
        :billable, :bill_address, :bill_address1, :bill_address2,
        :bill_address3, :bill_addressee, :bill_attention, :bill_city,
        :bill_country, :bill_country_code, :billed_date, :billing_amount,
        :billing_transaction, :bill_phone, :bill_state, :bill_variance_status,
        :bill_zip, :bin_number, :bin_number_quantity, :bom_quantity,
        :build_entire_assembly, :build_variance, :built,
        :can_have_stackable_promotions, :catch_up_period, :cc_customer_code,
        :cc_exp_date, :cc_holder_name, :cc_number, :cc_street, :cc_zip_code,
        :cleared, :closed, :close_date, :cogs_amount,
        :commission_effective_date, :commit, :component_yield,
        :confirmation_number, :contribution, :contribution_primary,
        :cost_component_amount, :cost_component_category, :cost_component_item,
        :cost_component_quantity, :cost_component_standard_cost, :cost_estimate,
        :cost_estimate_rate, :cost_estimate_type, :created_by, :credit_amount,
        :csc_match, :custom_gl, :cust_type, :date_created, :days_open,
        :days_overdue, :debit_amount, :defer_rev_rec, :deposit_date,
        :deposit_transaction, :doc_unit, :dr_account, :effective_rate,
        :entity_status, :est_gross_profit_pct, :exclude_from_rate_request,
        :expected_close_date, :expected_receipt_date, :expense_category,
        :expense_date, :firmed, :forecast_type, :fulfilling_transaction,
        :fx_account, :fx_amount, :fx_cost_estimate, :fx_cost_estimate_rate,
        :fx_est_gross_profit, :fx_tran_cost_estimate, :fx_vsoe_allocation,
        :fx_vsoe_amount, :fx_vsoe_price, :gco_availabel_to_charge,
        :gco_available_to_refund, :gco_avs_street_match, :gco_avs_zip_match,
        :gco_buyer_account_age, :gco_buyer_ip, :gco_charge_amount,
        :gco_chargeback_amount, :gco_confirmed_charged_total,
        :gco_confirmed_refunded_total, :gco_creditcard_number, :gco_csc_match,
        :gco_financial_state, :gco_fulfillment_state, :gco_order_id,
        :gco_order_total, :gco_promotion_amount, :gco_promotion_name,
        :gco_refund_amount, :gco_shipping_total, :gco_state_changed_detail,
        :gift_cert, :gross_amount, :include_in_forecast, :incoterm,
        :interco_status, :interco_transaction, :inventory_location,
        :inventory_subsidiary, :in_vsoe_bundle, :is_allocation, :is_backflush,
        :is_gco_chargeback, :is_gco_charge_confirmed,
        :is_gco_payment_guaranteed, :is_gco_refund_confirmed,
        :is_inside_delivery, :is_inside_pickup, :is_intercompany_adjustment,
        :is_in_transit_payment, :is_multi_ship_to, :is_reversal,
        :is_rev_rec_transaction, :is_scrap, :is_ship_address,
        :is_transfer_price_costing, :is_wip, :item, :item_fulfillment_choice,
        :item_revision, :landed_cost_per_line, :line, :line_sequence_number,
        :line_unique_key, :location_auto_assigned, :main_line, :main_name,
        :manufacturing_routing, :match_bill_to_receipt, :memo_main, :memorized,
        :merchant_account, :multi_subsidiary, :net_amount, :net_amount_no_tax,
        :next_bill_date, :no_auto_assign_location, :non_reimbursable,
        :one_time_total, :options, :order_allocation_strategy, :order_priority,
        :originator, :overhead_parent_item,
        :override_installments, :package_count, :paid_amount, :paid_transaction,
        :partner_contribution, :partner_role, :partner_team_member,
        :paying_amount, :paying_transaction, :payment_approved,
        :payment_event_date, :payment_event_hold_reason,
        :payment_event_purchase_card_used, :payment_event_purchase_data_sent,
        :payment_event_result, :payment_event_type, :payment_hold,
        :payment_method, :payment_option, :pay_pal_pending, :pay_pal_status,
        :pay_pal_tran_id, :payroll_batch, :pn_ref_num, :po_rate, :posting,
        :price_level, :print, :probability, :projected_amount, :project_task,
        :purchase_order, :quantity, :quantity_billed, :quantity_committed,
        :quantity_packed, :quantity_picked, :quantity_rev_committed,
        :quantity_ship_recv, :quantity_uom, :rate,
        :realized_gain_posting_transaction, :recur_annually_total,
        :recur_monthly_total, :recur_quarterly_total, :recur_weekly_total,
        :ref_number, :requested_date, :rev_commit_status,
        :rev_committing_transaction, :reversal_date, :reversal_number,
        :rg_account, :rg_amount, :sales_order, :sales_team_member,
        :sales_team_role, :scheduling_method, :serial_number,
        :serial_number_cost, :serial_number_cost_adjustment,
        :serial_number_quantity, :serial_numbers, :ship_address, :ship_address1,
        :ship_address2, :ship_address3, :ship_addressee, :ship_attention,
        :ship_carrier, :ship_city, :ship_complete, :ship_country,
        :ship_country_code, :ship_group, :ship_phone, :shipping_amount,
        :ship_recv_status_line, :ship_state, :ship_to, :ship_zip,
        :signed_amount, :subscription, :subscription_line, :tax_amount,
        :tax_code, :tax_line, :tax_period, :term_in_months, :terms_of_sale,
        :title, :to_subsidiary, :tran_est_gross_profit,
        :tran_fx_est_gross_profit, :transaction_discount,
        :transaction_line_type, :transaction_number, :transfer_location,
        :transfer_order_item_line, :transfer_order_quantity_committed,
        :transfer_order_quantity_packed, :transfer_order_quantity_picked,
        :transfer_order_quantity_received, :transfer_order_quantity_shipped,
        :type, :unit, :unit_cost_override, :vend_type, :visible_to_customer,
        :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered,
        :vsoe_permit_discount, :vsoe_price, :web_site
        # TODO: Add record_type, conflicts with Support::Records#record_type, returns "invoice" versus "tranSales:Invoice"

      record_refs :account, :bill_address_list, :custom_form, :department, :entity, :klass, :partner,
                  :posting_period, :ship_address_list, :terms, :location, :sales_rep, :tax_item, :created_from,
                  :ship_method, :lead_source, :promo_code, :subsidiary, :currency, :approval_status, :job, :discount_item

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
