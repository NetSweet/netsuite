require 'spec_helper'

describe NetSuite::Records::SupportCase do
  let(:support_case) { NetSuite::Records::SupportCase.new }

  it 'has all the right fields' do
    [
      :end_date, :incoming_message, :outgoing_message, :search_solution, :email_form,
      :internal_only, :title, :case_number, :start_date, :email, :phone, :inbound_email,
      :is_inactive, :help_desk
    ].each do |field|
      support_case.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :custom_form, :company, :contact, :issue, :status, :priority, :origin, :category, :assigned
    ].each do |record_ref|
      support_case.should have_record_ref(record_ref)
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
      support_case.custom_field_list = attributes
      support_case.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      support_case.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      support_case.custom_field_list = custom_field_list
      support_case.custom_field_list.should eql(custom_field_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :title => 'Case title' }) }

      it 'returns a SupportCase instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::SupportCase, :external_id => 1], {}).and_return(response)
        support_case = NetSuite::Records::SupportCase.get(:external_id => 1)
        support_case.should be_kind_of(NetSuite::Records::SupportCase)
        support_case.title.should == 'Case title'
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::SupportCase, :external_id => 1], {}).and_return(response)
        lambda {
          NetSuite::Records::SupportCase.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::SupportCase with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:support_case) { NetSuite::Records::SupportCase.new(:title => 'Case title') }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with([support_case], {}).
            and_return(response)
        support_case.add.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with([support_case], {}).
            and_return(response)
        support_case.add.should be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([support_case], {}).
            and_return(response)
        support_case.delete.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([support_case], {}).
            and_return(response)
        support_case.delete.should be_falsey
      end
    end
  end

  describe '.update' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :title => 'Case title' }) }

      it 'returns true' do
        NetSuite::Actions::Update.should_receive(:call).with([NetSuite::Records::SupportCase, :external_id => 1, :title => 'Case title'], {}).and_return(response)
        support_case = NetSuite::Records::SupportCase.new(:external_id => 1)
        support_case.update(:title => 'Case title').should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Update.should_receive(:call).with([NetSuite::Records::SupportCase, :internal_id => 1, :title => 'Case title'], {}).and_return(response)
        support_case = NetSuite::Records::SupportCase.new(:internal_id => 1)
        support_case.update(:title => 'Case title').should be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:support_case) { NetSuite::Records::SupportCase.new(:title => 'Case title') }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      support_case.to_record.should eql({
        'listSupport:title' => 'Case title'
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      support_case.record_type.should eql('listSupport:SupportCase')
    end
  end

end
