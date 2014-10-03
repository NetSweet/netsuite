module NetSuite
  module Support
    class GenericList

      # This is very experimental: idea to replace many of the 
      # generic list classes that are cluttering up the code base

      attr_accessor :list

      def initialize(attributes = {})

        @list_key = attributes.keys.first

        list = attributes[@list_key]
        list = [ list ] if !list.is_a?(Array)

        @list = list.map do |item|
          NetSuite::Records::RecordRef.new(item)
        end

      end

      def to_record
        # TODO need a way to infer record namespace
        { "#{record_namespace}:item" => @list.map(&:to_record) }
      end

    end
  end
end
