module NetSuite
  module Records
    class EntityCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :get_list, :add, :delete, :update, :upsert, :upsert_list

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/record/entitycustomfield.html
      fields(
        :access_level,
        :applies_to_contact,
        :applies_to_customer,
        :applies_to_employee,
        :applies_to_group,
        :applies_to_other_name,
        :applies_to_partner,
        :applies_to_price_list,
        :applies_to_statement,
        :applies_to_vendor,
        :applies_to_web_site,
        :available_externally,
        :check_spelling,
        :default_checked,
        :display_type,
        :field_type,
        :global_search,
        :is_formula,
        :is_mandatory,
        :is_parent,
        :label,
        :script_id,
        :search_level,
        :show_in_list,
        :store_value,
      )

      record_refs :owner

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
