module NetSuite
  module Records
    class TranslationList < Support::Sublist
      include NetSuite::Namespaces::ListAcct

      sublist :translation, NetSuite::Records::Translation

      alias translations translation
    end
  end
end
