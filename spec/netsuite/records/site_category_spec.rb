require 'spec_helper'

describe NetSuite::Records::SiteCategory do
  let(:site_category) { NetSuite::Records::SiteCategory.new }

  it 'has all the right fields' do
    [
      :description, :exclude_from_site_map, :is_inactive, :is_online,
      :item_id, :meta_tag_html, :page_title, :presentation_item_list,
      :search_keywords, :sitemap_priority, :store_detailed_description,
      :translations_list, :url_component
    ].each do |field|
      site_category.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :category_list_layout, :correlated_items_list_layout, :item_list_layout, :parent_category,
      :related_items_list_layout, :store_display_image, :store_display_thumbnail, :website
    ].each do |record_ref|
      site_category.should have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :url_component => 'some url' }) }

      it 'returns a SiteCategory instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::SiteCategory, :external_id => 1], {}).and_return(response)
        site_category = NetSuite::Records::SiteCategory.get(:external_id => 1)
        site_category.should be_kind_of(NetSuite::Records::SiteCategory)
        site_category.url_component.should == 'some url'
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::SiteCategory, :external_id => 1], {}).and_return(response)
        lambda {
          NetSuite::Records::SiteCategory.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::SiteCategory with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
