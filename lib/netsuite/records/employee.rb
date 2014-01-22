module NetSuite
  module Records
    class Employee
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListEmp

      actions :get, :add, :delete, :update, :search

      fields :salutation, :first_name, :middle_name, :last_name, :email, :alt_name,
        :phone, :fax, :default_address, :is_inactive, :last_modified_date, :date_created, :phonetic_name,
        :initials, :entity_id

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
