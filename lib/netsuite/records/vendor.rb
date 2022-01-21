module NetSuite
  module Records
    class Vendor
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :update, :upsert, :delete, :search

      fields :account_number, :alt_email, :alt_name, :alt_phone,
             :bcn, :bill_pay, :comments, :company_name, :credit_limit,
             :date_created, :default_address, :eligible_for_commission,
             :email, :email_preference, :email_transactions, :entity_id, :fax, :fax_transactions,
             :first_name, :give_access, :global_subscription_status, :home_phone, :is1099_eligible,
             :is_accountant, :is_inactive, :is_job_resource_vend, :is_person, :labor_cost,
             :last_name, :legal_name, :middle_name, :mobile_phone, :opening_balance,
             :opening_balance_date, :password, :password2, :phone, :phonetic_name, :pricing_schedule_list,
             :print_on_check_as, :print_transactions, :require_pwd_change, :roles_list, :salutation,
             :send_email, :subscriptions_list, :tax_id_num, :title,
             :url, :vat_reg_number

      field :custom_field_list, CustomFieldList
      field :currency_list, VendorCurrencyList
      # TODO should change name to VendorAddressBookList
      field :addressbook_list, CustomerAddressbookList

      read_only_fields :balance_primary, :balance, :last_modified_date, :unbilled_orders,
                       :unbilled_orders_primary

      record_refs :custom_form, :category, :image, :subsidiary, :representing_subsidiary,
                  :expense_account, :payables_account, :terms, :opening_balance_account, :currency, :work_calendar,
                  :tax_item

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
