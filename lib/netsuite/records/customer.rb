module NetSuite
  module Records
    class Customer
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :delete_list, :search, :attach_file

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/customer.html

      fields :account_number,
             :aging,
             :aging1,
             :aging2,
             :aging3,
             :aging4,
             :alcohol_recipient_type,
             :alt_email,
             :alt_name,
             :alt_phone,
             :bill_pay,
             :click_stream,
             :comments,
             :company_name,
             :consol_aging,
             :consol_aging1,
             :consol_aging2,
             :consol_aging3,
             :consol_aging4,
             :consol_days_overdue,
             :contrib_pct,
             :credit_hold_override,
             :credit_limit,
             :date_created,
             :days_overdue,
             :default_address,
             :default_order_priority,
             :display_symbol,
             :email,
             :email_preference,
             :email_transactions,
             :end_date,
             :entity_id,
             :estimated_budget,
             :fax,
             :fax_transactions,
             :first_name,
             :first_visit,
             :give_access,
             :global_subscription_status,
             :home_phone,
             :is_budget_approved,
             :is_inactive,
             :is_person,
             :keywords,
             :language,
             :last_modified_date,
             :last_name,
             :last_page_visited,
             :last_visit,
             :middle_name,
             :mobile_phone,
             :monthly_closing,
             :negative_number_format,
             :number_format,
             :opening_balance,
             :opening_balance_date,
             :override_currency_format,
             :password,
             :password2,
             :phone,
             :phonetic_name,
             :print_on_check_as,
             :print_transactions,
             :referrer,
             :reminder_days,
             :require_pwd_change,
             :resale_number,
             :salutation,
             :send_email,
             :ship_complete,
             :stage,
             :start_date,
             :symbol_placement,
             :sync_partner_teams,
             :taxable,
             :tax_exempt,
             :third_party_acct,
             :third_party_country,
             :third_party_zipcode,
             :title,
             :url,
             :vat_reg_number,
             :visits,
             :web_lead

      field :addressbook_list, CustomerAddressbookList
      field :contact_roles_list, ContactAccessRolesList
      field :credit_cards_list, CustomerCreditCardsList
      field :currency_list, CustomerCurrencyList
      field :custom_field_list, CustomFieldList
      # field :download_list, CustomerDownloadList # TODO Implement me
      # field :group_pricing_list, CustomerGroupPricingList # TODO: Implement me
      # field :item_pricing_list, CustomerItemPricingList # TODO: Implement me
      field :partners_list, CustomerPartnersList
      field :sales_team_list, CustomerSalesTeamList
      field :subscriptions_list, SubscriptionsList
      # field :tax_registration_list, CustomerTaxRegistrationList # TODO: Implement me

      read_only_fields :balance, :consol_balance, :deposit_balance, :consol_deposit_balance, :overdue_balance,
        :consol_overdue_balance, :unbilled_orders, :consol_unbilled_orders

      search_only_fields :address,
                         :address1,
                         :address2,
                         :address3,
                         :addressee,
                         :address_internal_id,
                         :address_label,
                         :address_phone,
                         :alt_contact,
                         :assigned_site,
                         :assigned_site_id,
                         :attention,
                         :available_offline,
                         :bill_address,
                         :bill_address1,
                         :bill_address2,
                         :bill_address3,
                         :bill_addressee,
                         :bill_attention,
                         :bill_city,
                         :bill_country,
                         :bill_country_code,
                         :bill_phone,
                         :bill_state,
                         :bill_zip_code,
                         :cc_customer_code,
                         :cc_default,
                         :cc_exp_date,
                         :cc_holder_name,
                         :cc_internal_id,
                         :cc_number,
                         :cc_state,
                         :cc_state_from,
                         :cc_type,
                         :city,
                         :contact,
                         :contribution,
                         :contribution_primary,
                         :conversion_date,
                         :country,
                         :country_code,
                         :credit_hold,
                         :date_closed,
                         :entity_number,
                         :explicit_conversion,
                         :first_order_date,
                         :first_sale_date,
                         :fx_balance,
                         :fx_consol_balance,
                         :fx_consol_unbilled_orders,
                         :fx_unbilled_orders,
                         :group_pricing_level,
                         :has_duplicates,
                         :is_default_billing,
                         :is_default_shipping,
                         :is_ship_address,
                         :item_pricing_level,
                         :item_pricing_unit_price,
                         :job_end_date,
                         :job_projected_end,
                         :job_start_date,
                         :job_type,
                         :last_order_date,
                         :last_sale_date,
                         :lead_date,
                         :level,
                         :manual_credit_hold,
                         :on_credit_hold,
                         :partner_contribution,
                         :partner_role,
                         :partner_team_member,
                         :pec,
                         :permission,
                         :pricing_group,
                         :pricing_item,
                         :prospect_date,
                         :role,
                         :sales_team_member,
                         :sales_team_role,
                         :ship_address,
                         :ship_address1,
                         :ship_address2,
                         :ship_address3,
                         :ship_addressee,
                         :ship_attention,
                         :ship_city,
                         :ship_country,
                         :ship_country_code,
                         :ship_phone,
                         :ship_state,
                         :ship_zip,
                         :source_site,
                         :source_site_id,
                         :state,
                         :subscription,
                         :subscription_date,
                         :subscription_status,
                         :zip_code

      record_refs :access_role,
                  :assigned_web_site,
                  :buying_reason,
                  :buying_time_frame,
                  :campaign_category,
                  :category,
                  :currency,
                  :custom_form,
                  :default_allocation_strategy,
                  :default_tax_reg,
                  :dr_account,
                  :entity_status,
                  :fx_account,
                  :image,
                  :lead_source,
                  :opening_balance_account,
                  :parent,
                  :partner,
                  :pref_cc_processor,
                  :price_level,
                  :receivables_account,
                  :representing_subsidiary,
                  :sales_group,
                  :sales_readiness,
                  :sales_rep,
                  :shipping_item,
                  :source_web_site,
                  :subsidiary,
                  :tax_item,
                  :terms,
                  :territory

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
