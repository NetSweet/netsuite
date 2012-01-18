module NetSuite
  module Records
    class PaymentMethod
      include Support::Fields
      include Support::RecordRefs

      fields :credit_card, :express_checkout_arrangement, :is_debit_card, :is_inactive, :is_online, :name,
        :pay_pal_email_address, :undep_funds, :use_express_checkout

      record_ref :account

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def self.get(options = {})
        response = Actions::Get.call(self, options)
        if response.success?
          new(response.body)
        else
          raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
        end
      end

    end
  end
end
