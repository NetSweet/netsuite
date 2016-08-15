module NetSuite
  module Records
    class UnitsTypeUomList < Support::Sublist
      include Namespaces::ListAcct

      sublist :uom, UnitsTypeUom

    end
  end
end


