module NetSuite
  module Records
    class CustomerCreditCardsList < Support::Sublist
      include Namespaces::ListRel

      sublist :credit_cards, CustomerCreditCards
      alias :credit_card :credit_cards
    end
  end
end
