module NetSuite
  module Records
    class Customer
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :delete_list, :search

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/customer.html

      fields :account_number, :aging, :alt_email, :alt_name, :alt_phone, :bill_pay,
        :buying_reason, :buying_time_frame, :campaign_category, :click_stream, :comments, :company_name,
        :consol_aging, :consol_days_overdue, :contrib_pct, :credit_hold_override,
        :credit_limit, :date_created, :days_overdue, :default_address,
        :download_list, :email, :email_preference, :email_transactions, :end_date, :entity_id,
        :estimated_budget, :fax, :fax_transactions, :first_name, :first_visit, :give_access, :global_subscription_status,
        :group_pricing_list, :home_phone, :image, :is_budget_approved, :is_inactive, :is_person, :item_pricing_list, :keywords,
        :language, :last_modified_date, :last_name, :last_page_visited, :last_visit, :middle_name, :mobile_phone,
        :opening_balance, :opening_balance_account, :opening_balance_date,
        :password, :password2, :phone, :phonetic_name, :pref_cc_processor, :print_on_check_as,
        :print_transactions, :referrer, :reminder_days, :representing_subsidiary, :require_pwd_change, :resale_number,
        :sales_group, :sales_readiness, :salutation, :send_email, :ship_complete,
        :stage, :start_date, :sync_partner_teams, :tax_exempt, :taxable,
        :third_party_acct, :third_party_country, :third_party_zipcode, :title, :url,
        :vat_reg_number, :visits, :web_lead

      field :addressbook_list,  CustomerAddressbookList
      field :credit_cards_list, CustomerCreditCardsList
      field :custom_field_list, CustomFieldList
      field :contact_roles_list, ContactAccessRolesList
      field :currency_list, CustomerCurrencyList
      field :partners_list, CustomerPartnersList
      field :subscriptions_list, CustomerSubscriptionsList
      field :sales_team_list, CustomerSalesTeamList

      read_only_fields :balance, :consol_balance, :deposit_balance, :consol_deposit_balance, :overdue_balance,
        :consol_overdue_balance, :unbilled_orders, :consol_unbilled_orders

      record_refs :access_role, :custom_form, :currency, :entity_status, :partner, :category, :lead_source,
        :price_level, :sales_rep, :subsidiary, :terms, :parent, :territory, :tax_item, :shipping_item, :receivables_account

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
    end
  end
end
