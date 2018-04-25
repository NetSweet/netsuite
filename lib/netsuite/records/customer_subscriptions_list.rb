module NetSuite
  module Records
    class CustomerSubscriptionsList < Support::Sublist
      include Namespaces::ListRel

      sublist :subscriptions, CustomerSubscription

    end
  end
end
