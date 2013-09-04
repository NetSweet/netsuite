# TODO specs
# TODO a transaction is actually the superclass of a SalesOrder, this is backwards

module NetSuite
  module Records
    class Transaction < SalesOrder

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
