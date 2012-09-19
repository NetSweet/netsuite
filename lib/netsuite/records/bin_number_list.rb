module NetSuite
  module Records
    # TODO this is fairly messy: shouldn't mix multiple classes in one file
    # might be possible to trash the GenericField as well
    
    class GenericField
      include Support::Attributes
      include Support::Fields

      def initialize(attributes = {})
        self.attributes = attributes
      end
    end

    class BinNumber < GenericField

    end

    class BinNumberList
      include Support::Fields
      include Namespaces::PlatformCore
      # include Namespaces::ListAcct

      fields :bin_number

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def bin_number=(items)
        case items
        when Hash
          self.bin_numbers << BinNumber.new(items)
        when Array
          items.each { |item| self.bin_numbers << BinNumber.new(item) }
        end
      end

      def bin_numbers
        @bin_numbers ||= []
      end

      def to_record
        { "#{record_namespace}:item" => bin_numbers.map(&:to_record) }
      end
    end
  end
end
