module NetSuite
  module Records
    class ProjectTask
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

      actions :get, :add, :search, :delete, :update

      fields :title, :message, :status, :percent_time_complete, :estimated_work,
             :start_date, :end_date, :finish_by_date, :actual_work, :remainig_work,
             :message, :created_date, :last_modified_date, :is_milestone, :late_start
             :late_end

      record_refs :parent, :owner, :company, :contact, :priority, :order

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
