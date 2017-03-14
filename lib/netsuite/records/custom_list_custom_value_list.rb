module NetSuite
  module Records
    
    class CustomListCustomValueList < Support::Sublist
      include Namespaces::SetupCustom

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/other/customlistcustomvaluelist.html?mode=package

      sublist :custom_value, CustomListCustomValue
    end

  end
end
