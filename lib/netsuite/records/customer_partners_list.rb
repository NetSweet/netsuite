module NetSuite
  module Records
    class CustomerPartnersList < Support::Sublist
      include Namespaces::ListRel

      sublist :partners, NetSuite::Records::CustomerPartner
    end
  end
end
