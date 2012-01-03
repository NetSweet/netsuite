module NetSuite
  module FieldSupport
    include AttributeSupport

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    def initialize(attributes = {})
      attributes = attributes.inject({}) do |hash, (k,v)|
        if k.to_s.match(/@.+/)
          hash.store(k.to_s.delete('@').to_sym, attributes[k])
        else
          hash.store(k,v)
        end
        hash
      end
      Hash[attributes.select { |k,v| self.class.fields.include?(k) }].each do |k,v|
        send("#{k}=", v)
      end
    end

    module ClassMethods

      def fields(*args)
        if args.empty?
           @fields
        else
          args.each do |arg|
            field arg
          end
        end
      end

      def field(name)
        name_sym = name.to_sym
        (@fields ||= Set.new) << name_sym
        define_method(name_sym) do
          attributes[name_sym]
        end

        define_method("#{name_sym}=") do |value|
          attributes[name_sym] = value
        end
      end

    end

  end
end
