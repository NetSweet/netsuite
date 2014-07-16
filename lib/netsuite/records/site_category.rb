module NetSuite
  module Records
    class SiteCategory
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListWebsite

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/sitecategory.html

      actions :get, :add, :delete, :update, :upsert, :search

      fields :description, :exclude_from_site_map, :is_inactive, :is_online,
        :item_id, :meta_tag_html, :page_title, :presentation_item_list,
        :search_keywords, :sitemap_priority, :store_detailed_description,
        :translations_list, :url_component

      record_refs :category_list_layout, :correlated_items_list_layout, :item_list_layout, :parent_category,
        :related_items_list_layout, :store_display_image, :store_display_thumbnail, :website

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
