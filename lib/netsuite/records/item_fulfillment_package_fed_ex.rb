module NetSuite
  module Records
    class ItemFulfillmentPackageFedEx
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :authorization_number_fed_ex, :cod_amount_fed_ex, :dry_ice_weight_fed_ex, :insured_value_fed_ex, :is_alcohol_fed_ex, 
              :is_non_haz_lithium_fed_ex, :is_non_standard_container_fed_ex, :package_height_fed_ex, :package_length_fed_ex, 
              :package_tracking_number_fed_ex, :package_weight_fed_ex, :package_width_fed_ex, :priority_alert_content_fed_ex, 
              :reference1_fed_ex, :signature_releasefed_ex, :use_cod_fed_ex, :use_insured_value_fed_ex


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
