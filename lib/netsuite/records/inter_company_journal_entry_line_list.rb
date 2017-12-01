module NetSuite
  module Records
    class InterCompanyJournalEntryLineList < Support::Sublist
      include Namespaces::TranGeneral

      attr_accessor :replace_all

      sublist :line, InterCompanyJournalEntryLine

      alias :lines :line

    end
  end
end
