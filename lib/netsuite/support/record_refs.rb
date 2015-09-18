module NetSuite
  module Support
    module RecordRefs

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def record_refs(*names)
          if names.empty?
            @record_refs ||= Set.new
          else
            names.each do |name|
              record_ref name
            end
          end
        end

        def record_ref(name)
          record_refs << name
          field name, NetSuite::Records::RecordRef
        end

      end

    end
  end
end
