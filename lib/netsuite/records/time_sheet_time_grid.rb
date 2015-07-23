module NetSuite
  module Records
    class TimeSheetTimeGrid
      include Support::Fields
      include Namespaces::TranEmp

      Date::DAYNAMES.each do |day|
        field day,   TimeEntry
      end
    end
  end
end
