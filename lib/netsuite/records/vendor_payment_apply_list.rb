module NetSuite
  module Records
    class VendorPaymentApplyList < Support::Sublist
      include Namespaces::TranPurch

      sublist :apply, VendorPaymentApply

      alias :applies :apply

    end
  end
end
