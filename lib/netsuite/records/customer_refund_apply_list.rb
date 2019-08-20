module NetSuite
  module Records
    class CustomerRefundApplyList < Support::Sublist
      include Namespaces::TranCust

      attr_accessor :replace_all

      sublist :apply, CustomerRefundApply

      alias :applies :apply

    end
  end
end
