module NetSuite
  module Support
    module RecordRefs

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def record_refs(*names)
          names.each do |name|
            record_ref name
          end
        end

        def record_ref(name)
          field name, NetSuite::Records::RecordRef
        end

      end

    end
  end
end
