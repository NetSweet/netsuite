module NetSuite
  module Records
    class InterCompanyJournalEntryLineList < Support::Sublist
      include Namespaces::TranGeneral

      sublist :line, InterCompanyJournalEntryLine

      alias :lines :line

    end
  end
end
