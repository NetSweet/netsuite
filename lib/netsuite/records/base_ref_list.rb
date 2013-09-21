# TODO needs spec

module NetSuite
  module Records
    class BaseRefList
      include Support::Fields
      include Support::Actions
      include Namespaces::PlatformCore

      actions :get_select_value

      fields :base_ref

      def initialize(attrs = {})
        initialize_from_attributes_hash(attrs)
      end

      def base_ref=(refs)
        case refs
        when Hash
          self.base_ref << RecordRef.new(refs)
        when Array
          refs.each { |ref| self.base_ref << RecordRef.new(ref) }
        end
      end

      def base_ref
        @base_ref ||= []
      end

    end
  end
end
