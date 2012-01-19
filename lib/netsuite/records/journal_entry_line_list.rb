module NetSuite
  module Records
    class JournalEntryLineList
      include Support::Fields

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

    end
  end
end
