module NetSuite
  module Records
    class LocationsList
      def initialize(attributes = {})
        attributes[:locations].each do |location|
          locations << location
        end if attributes[:locations]
      end

      def locations
        @locations ||= []
      end
    end
  end
end
