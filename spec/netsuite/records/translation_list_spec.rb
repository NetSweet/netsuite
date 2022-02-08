require 'spec_helper'

describe NetSuite::Records::TranslationList do
  let(:list) { NetSuite::Records::TranslationList.new }

  it 'has a translations attribute' do
    expect(list.translations).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.translations << NetSuite::Records::Translation.new(
        locale: '_englishUK',
        language: 'English (UK)',
        display_name: 'display name',
        sales_description: 'sales description'
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
        "listAcct:translation" => [
          {
            "listAcct:locale" => "_englishUK",
            "listAcct:language" => "English (UK)",
            "listAcct:displayName" => "display name",
            "listAcct:salesDescription" => "sales description"
          }
        ]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
