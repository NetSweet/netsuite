require 'spec_helper'

describe NetSuite::Records::Note do
  let(:note) { NetSuite::Records::Note.new }

  it 'has all the right fields' do
    [
      :direction, :lastModifiedDate, :note, :noteDate, :title, :topic
    ].each do |field|
      expect(note).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :noteType, :activity, :author, :customForm, :entity, :folder, :item, :media, :record, :recordType, :transaction
    ].each do |record_ref|
      expect(note).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_something'
        }
      }
      note.custom_field_list = attributes
      expect(note.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(note.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      note.custom_field_list = custom_field_list
      expect(note.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :note => 'Test Note', :direction => '_outgoing' }) }

      it 'returns a note instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Note, {:internal_id => 1}], {}).and_return(response)
        note = NetSuite::Records::Note.get(:internal_id => 1)
        expect(note).to be_kind_of(NetSuite::Records::Note)
        expect(note.note).to eq 'Test Note'
        expect(note.direction).to eq '_outgoing'
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Note, {:internal_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Note.get(:internal_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Note with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:note) { NetSuite::Records::Note.new(:note => 'TEST note', :entity => NetSuite::Records::RecordRef.new(internalId: 1, type: 'Customer') ) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([note], {}).
            and_return(response)
        expect(note.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([note], {}).
            and_return(response)
        expect(note.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([note], {}).
            and_return(response)
        expect(note.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([note], {}).
            and_return(response)
        expect(note.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:note) { NetSuite::Records::Note.new(:note => 'TEST note', :direction => '_outgoing' ) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(note.to_record).to eql({
        'commGeneral:note' => 'TEST note',
        'commGeneral:direction' => '_outgoing',
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(note.record_type).to eql('commGeneral:Note')
    end
  end
end
