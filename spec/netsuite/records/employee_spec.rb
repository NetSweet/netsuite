require 'spec_helper'

describe NetSuite::Records::Employee do
  let(:employee) { NetSuite::Records::Employee.new }

  it 'has all the expected fields' do
    %w{
      account_number
      alien_number
      alt_name
      approval_limit
      bill_pay
      birth_date
      comments
      date_created
      default_address
      direct_deposit
      eligible_for_commission
      email
      entity_id
      expense_limit
      fax
      first_name
      gender
      give_access
      hire_date
      home_phone
      is_inactive
      is_job_resource
      is_sales_rep
      is_support_rep
      job_description
      klass
      labor_cost
      last_modified_date
      last_name
      last_review_date
      middle_name
      mobile_phone
      next_review_date
      office_phone
      password
      password2
      pay_frequency
      phone
      phonetic_name
      purchase_order_approval_limit
      purchase_order_approver
      purchase_order_limit
      release_date
      resident_status
      salutation
      send_email
      social_security_number
      title
      visa_exp_date
      visa_type
    }.map(&:to_sym).each do |field|
      expect(employee).to have_field(field)
    end
  end

  it 'has all the expected record_refs' do
    %w{
      currency
      department
      employee_status
      employee_type
      location
      subsidiary
      supervisor
    }.map(&:to_sym).each do |record_ref|
      expect(employee).to have_record_ref(record_ref)
    end
  end

  describe '#roles_list' do
    it 'can be set from attributes'
    it 'can be set from a RoleList object'
  end

  describe '#get' do
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

  describe '#update' do
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
    let(:employee) do
      emp = NetSuite::Records::Employee.new(:email => 'bob@example.com')
      emp.custom_field_list.foo = 'bar'
      emp
    end

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(employee.to_record).to eql({
        'listEmp:customFieldList!' => {
          'platformCore:customField' => [
            {
              'platformCore:value' => 'bar',
              '@scriptId' => 'foo',
              '@xsi:type' => 'platformCore:StringCustomFieldRef'
            }
          ]
        },
        'listEmp:email' => 'bob@example.com'
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(employee.record_type).to eql('listEmp:Employee')
    end
  end
end
