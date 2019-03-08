module NetSuite
  module Records
    class BinNumberList < Support::Sublist
      include Namespaces::ListAcct

      sublist :bin_number, BinNumber

      alias :bin_numbers :bin_number
    end
  end
end
