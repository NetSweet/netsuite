require 'spec_helper'

describe NetSuite::Records::PromotionCode do
  let(:promo_code) { NetSuite::Records::PromotionCode.new }

  it 'has all the right fields' do
    [ :code, :code_pattern, :description, :discount_type, :display_line_discounts, :end_date,
             :exclude_items, :is_inactive, :is_public, :minimum_order_amount, :name, :number_to_generate,
             :rate, :start_date
    ].each do |field|
      promo_code.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :code => 'SUMMERSALE' }) }

      it 'returns a Campaign instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::PromotionCode, {:external_id => 1}], {}).and_return(response)
        promo_code = NetSuite::Records::PromotionCode.get(:external_id => 1)
        promo_code.should be_kind_of(NetSuite::Records::PromotionCode)
        promo_code.code.should eql('SUMMERSALE')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::PromotionCode, {:external_id => 1}], {}).and_return(response)
        lambda {
          NetSuite::Records::PromotionCode.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::PromotionCode with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
