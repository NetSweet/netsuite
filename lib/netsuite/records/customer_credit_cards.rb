module NetSuite
  module Records
    class CustomerCreditCards
      include Support::Fields
      include Support::RecordRefs
      include Support::Records

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/other/customercreditcards.html?mode=package

      fields :cc_default, :cc_expire_date, :cc_memo, :cc_name, :cc_number, :debitcard_issue_no, :state_from, :validfrom
      record_refs :card_state, :payment_method

      attr_reader :internal_id

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when self.class
          initialize_from_record(attributes_or_record)
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        end
      end

      def initialize_from_record(obj)
        self.cc_default = obj.cc_default
        self.cc_expire_date = obj.cc_expire_date
        self.cc_memo = obj.cc_memo
        self.cc_name = obj.cc_name
        self.cc_number = obj.cc_number
        self.debitcard_issue_no = obj.debitcard_issue_no
        self.state_from = obj.state_from
        self.validfrom = obj.validfrom
      end
    end
  end
end
