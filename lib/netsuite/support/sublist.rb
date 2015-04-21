module NetSuite
  module Support
    class Sublist
      include Support::Fields

      class << self

        def sublist(key, klass)
          field key

          # TODO setting class methods might be better? How to reach into the subclass?

          define_method(:sublist_key) { key }
          define_method(:sublist_class) { klass }

          define_method("#{key}=") do |list|
            self.process_sublist(list)
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
        rec = { "#{record_namespace}:#{sublist_key.to_s.lower_camelcase}" => send(self.sublist_key).map(&:to_record) }

        if !replace_all.nil?
          rec["#{record_namespace}:replaceAll"] = replace_all
        end

        rec
      end

      def <<(item)
        @list << self.process_sublist_item(item)
      end

      protected
        def process_sublist(list)
          list = [ list ] if !list.is_a?(Array)

          @list = list.map do |item|
            self.process_sublist_item(item)
          end
        end

        def process_sublist_item(item)
          if item.class == self.sublist_class
            item
          else
            self.sublist_class.new(item)
          end
        end

    end
  end
end
