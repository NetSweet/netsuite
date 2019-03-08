module NetSuite
  module Records
    class BinNumber
      include Support::Fields
      include Support::Records
      include Support::RecordRefs
      include Namespaces::ListAcct

      record_ref :bin_number

      fields :preferred_bin, :location

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
