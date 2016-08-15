module NetSuite
  module Records
    class JournalEntryLineList < Support::Sublist
      include Namespaces::TranGeneral

      sublist :line, JournalEntryLine

      alias :lines :line

    end
  end
end
