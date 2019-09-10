require 'spec_helper'

describe NetSuite::Records::CustomerSalesTeamList do
  let(:list) { NetSuite::Records::CustomerSalesTeamList.new }

  it 'has an customer_sales_team attribute' do
    expect(list.sales_team).to be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      list.replace_all = true

      record = {
        'listRel:salesTeam' => [],
        'listRel:replaceAll' => true
      }
      expect(list.to_record).to eql(record)
    end
  end

  describe "#replace_all" do
    it "can be changed via accessor" do
      list.replace_all = false

      expect(list.replace_all).to eql(false)
    end

    it "coerces to a boolean" do
      list.replace_all = "goober"

      record = {
        'listRel:salesTeam' => [],
        'listRel:replaceAll' => true
      }

      expect(list.to_record).to eql(record)
    end
  end

end
