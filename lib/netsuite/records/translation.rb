module NetSuite
  module Records
    class Translation
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :description, :display_name, :featured_description, :language, :locale, :locale_description, :name,
             :no_price_message, :out_of_stock_message, :page_title, :replace_all, :sales_description,
             :specials_description, :store_description, :store_detailed_description, :store_display_name

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
