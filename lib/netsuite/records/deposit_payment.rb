module NetSuite
  module Records
    class DepositPayment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranBank

      # <element name="deposit" type="xsd:boolean" minOccurs="0"/>
      # <element name="id" type="xsd:long" minOccurs="0"/>
      # <element name="docDate" type="xsd:dateTime" minOccurs="0"/>
      # <element name="type" type="xsd:string" minOccurs="0"/>
      # <element name="docNumber" type="xsd:string" minOccurs="0"/>
      # <element name="memo" type="xsd:string" minOccurs="0"/>
      # <element name="paymentMethod" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="refNum" type="xsd:string" minOccurs="0"/>
      # <element name="entity" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="currency" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="transactionAmount" type="xsd:double" minOccurs="0"/>
      # <element name="paymentAmount" type="xsd:double" minOccurs="0"/>

      fields :deposit, :id, :doc_date, :type, :doc_number, :memo, :ref_num, :transaction_amount, :payment_amount, :lineid

      record_refs :entity, :currency, :payment_method

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
