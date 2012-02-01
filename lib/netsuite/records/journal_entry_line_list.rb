module NetSuite
  module Records
    class JournalEntryLineList
      include Support::Fields
      include Namespaces::TranGeneral
      
      fields :line

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def line=(lines)
        case lines
        when Hash
          self.lines << JournalEntryLine.new(lines)
        when Array
          lines.each { |line| self.lines << JournalEntryLine.new(line) }
        end
      end

      def lines
        @items ||= []
      end

      def to_record
        { "#{record_namespace}:line" => lines.map(&:to_record) }
      end

    end
  end
end
