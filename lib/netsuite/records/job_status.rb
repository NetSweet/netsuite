module NetSuite
  module Records
    class JobStatus
      include Support::Fields
      include Support::Records
      include Support::Actions

      actions :get, :add, :delete, :update, :search

      fields :name, :description, :allow_expenses, :allow_time, :is_inactive

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
