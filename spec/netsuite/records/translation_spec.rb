require 'spec_helper'

describe NetSuite::Records::Translation do
  let(:translation) { NetSuite::Records::Translation.new }

  it 'has dynamic fields' do
    [
      :description,
      :display_name,
      :featured_description,
      :language,
      :locale,
      :locale_description,
      :name,
      :no_price_message,
      :out_of_stock_message,
      :page_title,
      :replace_all,
      :sales_description,
      :specials_description,
      :store_description,
      :store_detailed_description,
      :store_display_name
    ].each do |field|
      expect(translation).to have_field(field)
    end
  end
end
