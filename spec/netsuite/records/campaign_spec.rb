require 'spec_helper'

describe NetSuite::Records::Campaign do
  let(:campaign) { NetSuite::Records::Campaign.new }

  it 'has all the right fields' do
    [ :audience, :base_cost, :campaign_direct_mail_list, :campaign_email_list,
      :campaign_event_list, :campaign_id, :category, :conv_cost_per_customer, :conversions,
      :cost, :cost_per_customer, :end_date, :event_response_list, :expected_revenue,
      :family, :is_inactive, :item_list, :keyword, :leads_generated, :message,
      :offer, :owner, :profit, :promotion_code, :roi, :search_engine, :start_date, :title,
      :total_revenue, :unique_visitors, :url, :vertical
    ].each do |field|
      campaign.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :message => 'Message 1' }) }

      it 'returns a Campaign instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Campaign, {:external_id => 1}], {}).and_return(response)
        campaign = NetSuite::Records::Campaign.get(:external_id => 1)
        campaign.should be_kind_of(NetSuite::Records::Campaign)
        campaign.message.should eql('Message 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Campaign, {:external_id => 1}], {}).and_return(response)
        lambda {
          NetSuite::Records::Campaign.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Campaign with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
