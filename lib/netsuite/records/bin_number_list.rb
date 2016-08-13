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
      include Support::Records

    end

    class BinNumberList < Support::Sublist
      include Namespaces::PlatformCore
      # include Namespaces::ListAcct

      sublist :bin_number, BinNumber

      alias :bin_numbers :bin_number

    end
  end
end
