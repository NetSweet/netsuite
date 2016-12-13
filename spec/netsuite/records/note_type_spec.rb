require 'spec_helper'

describe NetSuite::Records::NoteType do
  let(:note_type) { NetSuite::Records::NoteType.new }

  it 'has all the right fields' do
    [
      :name, :description, :is_inactive
    ].each do |field|
      expect(note_type).to have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'E-mail', :is_inactive => false }) }

      it 'returns a note_type instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::NoteType, {:internal_id => 1}], {}).and_return(response)
        note_type = NetSuite::Records::NoteType.get(:internal_id => 1)
        expect(note_type).to be_kind_of(NetSuite::Records::NoteType)
        expect(note_type.name).to eq 'E-mail'
        expect(note_type.is_inactive).to be_falsy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::NoteType, {:internal_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::NoteType.get(:internal_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::NoteType with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.search' do
    context 'when the response is successful' do

      it 'returns a NoteType instance populated with the data from the response object' do
        body = {
          total_records: 1,
          record_list: {
            record: [
              {name: 'E-mail', :is_inactive => false },
            ]
          }
        }

        allow(NetSuite::Actions::Search).to receive(:call).with(
          [NetSuite::Records::NoteType, {:is_inactive => false}], {}
        ).and_return(
          NetSuite::Response.new(:success => true, :body => body)
        )

        search_result = NetSuite::Records::NoteType.search(:is_inactive => false)

        expect(search_result).to be_a NetSuite::Support::SearchResult
        expect(search_result.total_records).to eq 1

        period1 = search_result.results.first

        expect(period1).to be_a NetSuite::Records::NoteType
        expect(period1.name).to eq 'E-mail'
      end
    end
  end

  describe '#to_record' do
    let(:note_type) { NetSuite::Records::NoteType.new(:name => 'E-mail', :is_inactive => false) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(note_type.to_record).to eql({
        'listAcct:name' => 'E-mail',
        'listAcct:isInactive' => false,
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(note_type.record_type).to eql('listAcct:NoteType')
    end
  end
end
