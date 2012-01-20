module NetSuite
  module Records
    class CustomerRefund
      include Support::Fields
      include Support::RecordRefs

      fields :address, :balance, :cc_approved, :cc_expire_date, :cc_name, :cc_number, :cc_street, :cc_zip_code, :charge_it,
        :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :last_modified_date, :memo, :pn_ref_num, :status,
        :to_be_printed, :total, :tran_date, :tran_id, :valid_from

      field :custom_field_list, CustomFieldList

      record_refs :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass,
        :location, :payment_method, :posting_period, :subsidiary, :void_journal

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

      def self.initialize(object)
        response = Actions::Initialize.call(self, object)
        if response.success?
          new(response.body)
        else
          raise InitializationError, "#{self}.initialize with #{object} failed."
        end
      end

    end
  end
end
