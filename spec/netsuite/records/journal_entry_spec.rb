require 'spec_helper'

describe NetSuite::Records::JournalEntry do
  let(:entry) { NetSuite::Records::JournalEntry.new }

  it 'has all the right fields' do
    [
     :approved, :created_date, :exchange_rate, :last_modified_date, :reversal_date,
     :reversal_defer, :reversal_entry, :tran_date, :tran_id
    ].each do |field|
      entry.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :created_from, :currency, :custom_form, :department, :klass, :location, :parent_expense_alloc, :posting_period,
      :subsidiary, :to_subsidiary
    ].each do |record_ref|
      entry.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :internal_id => 'custfield_amount'
        }
      }
      entry.custom_field_list = attributes
      entry.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      entry.custom_field_list.custom_fields.length.should eql(1)
      entry.custom_field_list.custfield_amount.attributes[:amount].should eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      entry.custom_field_list = custom_field_list
      entry.custom_field_list.should eql(custom_field_list)
    end
  end

  describe '#line_list' do
    it 'can be set from attributes' do
      attributes = {
        :line => {

        }
      }
      entry.line_list = attributes
      entry.line_list.should be_kind_of(NetSuite::Records::JournalEntryLineList)
      entry.line_list.lines.length.should eql(1)
    end

    it 'can be set from a JournalEntryLineList object' do
      line_list = NetSuite::Records::JournalEntryLineList.new
      entry.line_list = line_list
      entry.line_list.should eql(line_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :approved => true }) }

      it 'returns a JournalEntry instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::JournalEntry, :external_id => 1).and_return(response)
        customer = NetSuite::Records::JournalEntry.get(:external_id => 1)
        customer.should be_kind_of(NetSuite::Records::JournalEntry)
        customer.approved.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::JournalEntry, :external_id => 1).and_return(response)
        lambda {
          NetSuite::Records::JournalEntry.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::JournalEntry with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:entry) { NetSuite::Records::JournalEntry.new(:approved => true) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with(entry).
            and_return(response)
        entry.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with(entry).
            and_return(response)
        entry.add.should be_false
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with(entry).
            and_return(response)
        entry.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with(entry).
            and_return(response)
        entry.delete.should be_false
      end
    end
  end

  describe '#to_record' do
    let(:entry) { NetSuite::Records::JournalEntry.new(:tran_id => '1234', :approved => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      entry.to_record.should eql({
        'tranGeneral:tranId'   => '1234',
        'tranGeneral:approved' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      entry.record_type.should eql('tranGeneral:JournalEntry')
    end
  end

end
