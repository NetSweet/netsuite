module NetSuite
  module Records
    class TimeSheet
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :start_date, :end_date

      field :total_hours,     Duration
      field :time_grid_list,  TimeSheetTimeGridList

      record_refs :approval_status, :custom_form, :employee, :subsidiary

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
