module NetSuite
  module Support
    module Attachment
      include Attributes
      include Namespaces::PlatformCore

      def to_attachment
        {
          "platformCore:attachTo" => {
            "xsi:type" => "platformCore:RecordRef",
            "internalId" => internal_id,
            "type" => soap_type,
          }
        }
      end

      def soap_type
        self.class.to_s.split('::').last.lower_camelcase
      end
    end
  end
end
