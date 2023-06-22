module NetSuite
  module Records
    class SubscriptionsList < Support::Sublist
      include Namespaces::ListRel

      sublist :subscriptions, Subscription

    end
  end
end
