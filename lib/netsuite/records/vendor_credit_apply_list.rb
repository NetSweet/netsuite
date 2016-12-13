module NetSuite
  module Records
    class VendorCreditApplyList < Support::Sublist
      include Namespaces::TranPurch

      sublist :apply, VendorCreditApply

      alias :applies :apply

    end
  end
end
