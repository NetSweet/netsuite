# http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2016_2/schema/other/attachcontactreference.html?mode=package

module NetSuite
  module Records
    class AttachContactReference
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions

      actions :attach

      record_refs :contact, :contact_role

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
