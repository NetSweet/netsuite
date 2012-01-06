module NetSuite
  module RecordRefSupport

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
        name_sym = name.to_sym
        define_method "#{name}=" do |attrs|
          attributes[name_sym] = NetSuite::Records::RecordRef.new(attrs)
        end

        define_method name_sym do
          attributes[name_sym]
        end
      end

    end

  end
end
