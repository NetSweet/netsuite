module NetSuite
  module Records
    class ItemFulfillmentPackageUps
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :additional_handling_ups, :cod_amount_ups, :cod_method_ups, :delivery_conf_ups, :insured_value_ups, :package_descr_ups,
        :package_height_ups, :package_length_ups, :package_tracking_number_ups, :package_weight_ups, :package_width_ups,
        :packaging_ups, :reference1_ups, :reference2_ups, :use_cod_ups


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
