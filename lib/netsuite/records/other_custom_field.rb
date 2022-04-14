module NetSuite
  module Records
    class OtherCustomField
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :add, :delete, :delete_list, :get, :get_list, :get_select_value, :update, :update_list, :upsert, :upsert_list

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2021_2/schema/record/othercustomfield.html


      fields :access_level,
             :check_spelling,
             :custom_Ssgment,
             :default_checked,
             :default_selection,
             :default_value,
             :dept_access_list,
             :description,
             :display_height,
             :display_type,
             :display_width,
             :dynamic_default,
             :filter_list,
             :help,
             :insert_before,
             :is_formula,
             :is_mandatory,
             :label,
             :link_text,
             :max_length,
             :max_value,
             :min_value,
             :role_access_list,
             :search_level,
             :show_in_list,
             :store_value,
             :sub_access_list,
             :translations_list


      record_refs :owner,
                  :rec_type,
                  :search_compare_field,
                  :search_default,
                  :select_record_type,
                  :source_filter_by,
                  :source_from,
                  :source_list


      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end

