module NetSuite
  module Records
    class Customer
      include FieldSupport
      include RecordSupport
      include RecordRefSupport

      fields :access_role, :account_number, :addressbook_list, :aging, :alt_email, :alt_name, :alt_phone, :balance, :bill_pay,
        :buying_reason, :buying_time_frame, :campaign_category, :category, :click_stream, :comments, :company_name,
        :consol_aging, :consol_balance, :consol_days_overdue, :consol_deposit_balance, :consol_overdue_balance,
        :consol_unbilled_orders, :contact_roles_list, :contrib_pct, :credit_cards_list, :credit_hold_override, :credit_limit,
        :currency, :currency_list, :custom_field_list, :date_created, :days_overdue, :default_address,
        :deposit_balance, :download_list, :email, :email_preference, :email_transactions, :end_date, :entity_id,
        :estimated_budget, :fax, :fax_transactions, :first_name, :first_visit, :give_access, :global_subscription_status,
        :group_pricing_list, :home_phone, :image, :is_budget_approved, :is_inactive, :is_person, :item_pricing_list, :keywords,
        :language, :last_modified, :last_name, :last_page_visited, :last_visit, :lead_source, :middle_name, :mobile_phone,
        :opening_balance, :opening_balance_account, :opening_balance_date, :overdue_balance, :parent, :partner, :partners_list,
        :password, :password_2, :phone, :phonetic_name, :pref_cc_processor, :price_level, :print_on_check_as,
        :print_transactions, :referrer, :reminder_days, :representing_subsidiary, :require_pwd_change, :resale_number,
        :sales_group, :sales_readiness, :sales_rep, :sales_team_list, :salutation, :send_email, :ship_complete, :shipping_item,
        :stage, :start_date, :subscriptions_list, :subsidiary, :sync_partner_teams, :tax_exempt, :tax_item, :taxable, :terms,
        :territory, :third_party_acct, :third_party_country, :third_party_zipcode, :title, :unbilled_orders, :url,
        :vat_reg_number, :visits, :web_lead

      record_refs :custom_form, :entity_status

      attr_reader :internal_id, :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def addressbook_list=(attrs)
        attributes[:addressbook_list] = CustomerAddressbookList.new(attrs)
      end

      def self.get(id)
        response = Actions::Get.call(id, self)
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
