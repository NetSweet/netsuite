module NetSuite
  module Records
    class DepositCashBack
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranBank

      # <element name="amount" type="xsd:double" minOccurs="0"/>
      # <element name="account" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="department" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="class" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="location" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="memo" type="xsd:string" minOccurs="0"/>

      fields :amount, :memo

      record_refs :account, :department, :klass, :location

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

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end
    end
  end
end
