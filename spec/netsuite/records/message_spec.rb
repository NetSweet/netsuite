require 'spec_helper'

describe NetSuite::Records::Message do
  let(:message) { NetSuite::Records::Message.new }

  it 'has all the right fields' do
    [
      :bcc, :cc, :compress_attachments, :date_time, :emailed,
      :incoming, :message, :record_name, :record_type_name, :subject,
      :last_modified_date, :message_date
    ].each do |field|
      expect(message).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :activity, :author, :recipient, :transaction
    ].each do |record_ref|
      expect(message).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => {message: 'message text'})}

      it 'returns a Message instance populated with data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Message, :external_id => 1], {}).and_return(response)

        message = NetSuite::Records::Message.get(:external_id => 1)
        expect(message).to be_kind_of(NetSuite::Records::Message)
        expect(message.message).to eq('message text')
      end
    end

    context 'when response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Message, :external_id => 1], {}).and_return(response)
        expect {
          NetSuite::Records::Message.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
                         /NetSuite::Records::Message with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
