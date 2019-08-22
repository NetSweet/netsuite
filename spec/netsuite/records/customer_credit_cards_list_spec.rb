require 'spec_helper'

describe NetSuite::Records::CustomerCreditCardsList do
  let(:list) { NetSuite::Records::CustomerCreditCardsList.new }

  it 'has a credit_cards attribute' do
    expect(list.credit_cards).to be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      list.replace_all = true

      record = {
        'listRel:creditCards' => [],
        'listRel:replaceAll' => true
      }

      expect(list.to_record).to eql(record)
    end
  end

end
