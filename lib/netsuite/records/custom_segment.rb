module NetSuite
  module Records
    class CustomSegment
      include Support::Fields
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2021_2/schema/record/customsegment.html
      fields :label,
             :script_id,
             :record_script_id,
             :record_type,
             :field_type,
             :is_inactive,
             :show_in_list,
             :has_lg_impact,
             :is_mandatory


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
