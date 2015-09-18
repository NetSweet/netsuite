module NetSuite
  module Records
    class DepositCashBackList < Support::Sublist
      include Namespaces::TranBank

      sublist :deposit_cash_back, DepositCashBack
    end
  end
end
