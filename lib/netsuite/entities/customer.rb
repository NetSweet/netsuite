module NetSuite
  class Customer

    def self.fields(*args)
      args.each do |arg|
        field arg
      end
    end

    def self.field(name)
      define_accessor(name.to_sym)
    end

    def self.define_accessor(name)
      define_method(name) do
        @attributes[name]
      end

      define_method("#{name}=") do |value|
        @attributes[name] = value
      end
    end

   fields  :custom_form, :entity_id, :alt_name, :is_person, :phonetic_name, :salutation, :first_name,
           :middle_name, :last_name, :company_name, :entity_status, :parent, :phone, :fax, :email, :url,
           :default_address, :is_inactive, :category, :title, :print_on_check_as, :alt_phone, :home_phone,
           :mobile_phone, :alt_email, :language, :comments, :date_created, :image, :email_preference,
           :subsidiary, :representing_subsidiary, :sales_rep, :territory, :contrib_pct, :partner,
           :sales_group, :vat_reg_number, :account_number, :tax_exempt, :terms, :credit_limit,
           :credit_hold_override, :balance, :overdue_balance, :days_overdue, :unbilled_orders,
           :consol_unbilled_orders, :consol_overdue_balance, :consol_deposit_balance, :consol_balance,
           :consol_aging, :consol_days_overdue, :price_level, :currency, :pref_cc_processor, :deposit_balance,
           :ship_complete, :taxable, :tax_item, :resale_number, :aging, :start_date, :end_date, :reminder_days,
           :shipping_item, :third_party_acct, :third_party_zipcode, :third_party_country, :give_access,
           :estimated_budget, :access_role, :send_email, :password, :password_2, :require_pwd_change,
           :campaign_category, :lead_source, :web_lead, :referrer, :keywords, :click_stream,
           :last_page_visited, :visits, :first_visit, :last_visit, :bill_pay, :opening_balance, :last_modified,
           :opening_balance_date, :opening_balance_account, :stage, :email_transactions, :print_transactions,
           :fax_transactions, :sync_partner_teams, :is_budget_approved, :global_subscription_status,
           :sales_readiness, :sales_team_list, :buying_reason, :download_list, :buying_time_frame,
           :addressbook_list, :subscriptions_list, :contact_roles_list, :currency_list, :credit_cards_list,
           :partners_list, :group_pricing_list, :item_pricing_list, :custom_field_list

    def initialize(attributes = {})
      @attributes = attributes
    end

    def self.get(id)
      response = NetSuite::Actions::Get.call(id)
      if response.success?
        new(response.body)
      else
        raise RecordNotFound, "#{self} with ID=#{id} could not be found"
      end
    end

    def add
      response = NetSuite::Actions::Add.call(@attributes)
      response.success?
    end

  end
end
