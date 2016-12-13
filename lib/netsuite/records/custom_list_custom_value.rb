module NetSuite
  module Records
    class CustomListCustomValue
      include Support::Records
      include Support::Fields
      include Namespaces::SetupCustom

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/other/customlistcustomvalue.html?mode=package

      fields :abbreviation, :value, :value_id, :is_inactive

      # field valueLanguageValueList

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
