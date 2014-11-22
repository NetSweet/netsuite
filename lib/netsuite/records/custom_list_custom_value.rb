module NetSuite
  module Records
    class CustomListCustomValue < Support::Base
      include Namespaces::SetupCustom

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/other/customlistcustomvalue.html?mode=package

      fields :abbreviation, :value, :value_id, :is_inactive

      # field valueLanguageValueList

    end
  end
end