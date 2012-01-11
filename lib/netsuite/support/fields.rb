module NetSuite
  module Support
    module Fields
      include Attributes

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def fields(*args)
          if args.empty?
             @fields ||= Set.new
          else
            args.each do |arg|
              field arg
            end
          end
        end

        def field(name)
          name_sym = name.to_sym
          fields << name_sym
          define_method(name_sym) do
            attributes[name_sym]
          end

          define_method("#{name_sym}=") do |value|
            attributes[name_sym] = value
          end
        end

        def read_only_fields(*args)
          if args.empty?
             @read_only_fields ||= Set.new
          else
            args.each do |arg|
              read_only_field arg
            end
          end
        end

        def read_only_field(name)
          name_sym = name.to_sym
          read_only_fields << name_sym
          field name
        end

      end

    end
  end
end
