module NetSuite
  module Records
    class InvoiceSalesTeamList < Support::Sublist
      include Namespaces::TranSales

      sublist :sales_team, NetSuite::Records::InvoiceSalesTeam
    end
  end
end
