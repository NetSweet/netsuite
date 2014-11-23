require 'spec_helper'

describe NetSuite::Records::PromotionCode do
  let(:promo_code) { NetSuite::Records::PromotionCode.new }

  it 'has all the right fields' do
    [ :code, :code_pattern, :description, :discount_type, :display_line_discounts, :end_date,
             :exclude_items, :is_inactive, :is_public, :minimum_order_amount, :name, :number_to_generate,
             :rate, :start_date
    ].each do |field|
      expect(promo_code).to have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :code => 'SUMMERSALE' }) }

      it 'returns a Campaign instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PromotionCode, {:external_id => 1}], {}).and_return(response)
        promo_code = NetSuite::Records::PromotionCode.get(:external_id => 1)
        expect(promo_code).to be_kind_of(NetSuite::Records::PromotionCode)
        expect(promo_code.code).to eql('SUMMERSALE')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::PromotionCode, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::PromotionCode.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::PromotionCode with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
