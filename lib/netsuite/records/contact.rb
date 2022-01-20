module NetSuite
  module Records
    class Contact
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_deleted, :get_list, :add, :delete, :delete_list, :search, :update, :upsert, :upsert_list

      fields :salutation, :first_name, :middle_name, :last_name, :title, :phone, :fax, :email, :default_address,
             :entity_id, :phonetic_name, :alt_email, :office_phone, :home_phone, :mobile_phone, :supervisor_phone,
             :assistant_phone, :comments, :bill_pay, :is_private, :is_inactive

      field :addressbook_list,  ContactAddressbookList
      field :custom_field_list, CustomFieldList
      # field :subscriptions_list, SubscriptionsList
      # field :category_list, CategoryList

      read_only_fields :last_modified_date, :date_created

      record_refs :custom_form, :company, :subsidiary, :supervisor, :assistant, :image, :global_subscription_status

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
