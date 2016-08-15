module NetSuite
  module Records
    class RecordRefList < Support::Sublist
      include Support::Records
      include Namespaces::PlatformCore

      sublist :record_ref, RecordRef

      def to_record
        {
          "#{record_namespace}:recordRef" => record_ref.map do |rr|
            rec = rr.to_record
            rec[:@internalId] = rr.internal_id if rr.internal_id
            rec[:@externalId] = rr.external_id if rr.external_id
            rec[:@type] = rr.type if rr.type
            rec
          end
        }
      end
    end
  end
end
