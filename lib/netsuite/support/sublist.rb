module NetSuite
  module Support
    class Sublist
      include Support::Fields

      class << self

        def sublist(key, klass)
          field key

          define_method(:sublist_key) { key }

          define_method("#{key}=") do |list|
            list = [ list ] if !list.is_a?(Array)

            @list = list.map do |item|
              klass.new(item)
            end
          end

          define_method("#{key}") do
            @list ||= []
          end
        end

      end

      field :replace_all

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = { "#{record_namespace}:#{sublist_key}" => send(self.sublist_key).map(&:to_record) }

        if !replace_all.nil?
          rec["#{record_namespace}:replaceAll"] = replace_all
        end

        rec
      end

    end
  end
end
