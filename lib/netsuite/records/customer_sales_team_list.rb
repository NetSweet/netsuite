module NetSuite
  module Records
    class CustomerSalesTeamList < Support::Sublist
      include Namespaces::ListRel

      sublist :sales_team, NetSuite::Records::CustomerSalesTeam
    end
  end
end
