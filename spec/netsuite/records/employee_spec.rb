require 'spec_helper'

describe NetSuite::Records::Employee do
  let(:employee) { NetSuite::Records::Employee.new }

  it 'has all the right fields' do
    [
      :email, :first_name, :give_access, :is_inactive, :is_sales_rep,
      :klass, :last_name, :middle_name, :phone, :send_email
    ].each do |field|
      expect(employee).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :location
    ].each do |record_ref|
      expect(employee).to have_record_ref(record_ref)
    end
  end

  describe '#roles_list' do
    it 'can be set from attributes'
    it 'can be set from a RoleList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :account_number => 7 }) }

      it 'returns an Employee instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Employee, { :external_id => 1 }], {}).and_return(response)
        employee = NetSuite::Records::Employee.get(:external_id => 1)
        expect(employee).to be_kind_of(NetSuite::Records::Employee)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Employee, { :external_id => 1 }], {}).and_return(response)
        expect {
          NetSuite::Records::Employee.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
                         /NetSuite::Records::Employee with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:employee) { NetSuite::Records::Employee.new(:email => 'dale.cooper@example.com') }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
                                            with([employee], {}).
                                            and_return(response)
        expect(employee.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
                                            with([employee], {}).
                                            and_return(response)
        expect(employee.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
                                               with([employee], {}).
                                               and_return(response)
        expect(employee.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
                                               with([employee], {}).
                                               and_return(response)
        expect(employee.delete).to be_falsey
      end
    end
  end

  describe '.update' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :email => 'leland.palmer@example.com' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Employee, { :internal_id => 1, :email => 'leland.palmer@example.com' }], {}).and_return(response)
        employee = NetSuite::Records::Employee.new(:internal_id => 1)
        expect(employee.update(:email => 'leland.palmer@example.com')).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Employee, { :internal_id => 1, :account_number => 7 }], {}).and_return(response)
        employee = NetSuite::Records::Employee.new(:internal_id => 1)
        expect(employee.update(:account_number => 7)).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:employee) { NetSuite::Records::Employee.new(:email => 'bob@example.com') }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(employee.to_record).to eql({ 'listEmp:email' => 'bob@example.com' })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(employee.record_type).to eql('listEmp:Employee')
    end
  end
end
