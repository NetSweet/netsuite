module NetSuite
  module Records
    class ItemFulfillmentPackageUsps
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :insured_value_usps, :package_descr_usps, :package_height_usps, :package_length_usps,
              :package_tracking_number_usps, :package_weight_usps, :package_width_usps, :reference1_usps, :reference2_usps, :use_insured_value_usps


      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
      end
    end
  end
end
