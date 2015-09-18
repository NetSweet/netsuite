module NetSuite
  module Records
    class DepositOtherList < Support::Sublist
      include Namespaces::TranBank

      sublist :deposit_other, DepositOther
    end
  end
end
