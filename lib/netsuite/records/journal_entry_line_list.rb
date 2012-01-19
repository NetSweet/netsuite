module NetSuite
  module Records
    class JournalEntryLineList
      include Support::Fields
      include Namespaces::TranGeneral

      def initialize(attributes = {})
        case attributes[:line]
        when Hash
          lines << JournalEntryLine.new(attributes[:line])
        when Array
          attributes[:line].each { |line| lines << JournalEntryLine.new(line) }
        end
      end

      def lines
        @lines ||= []
      end

      def to_record
        lines.map do |line|
          { "#{record_namespace}:line" => line.to_record }
        end
      end

    end
  end
end
