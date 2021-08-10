require 'spec_helper'

describe NetSuite::Records::ExpenseReport do
  let(:entry) { NetSuite::Records::ExpenseReport.new }

  it 'has all the right fields' do
    [
     :accounting_approval, :advance, :amount, :complete, :created_date,
     :due_date, :last_modified_date, :memo, :status, :supervisor_approval,
     :tax1_amt, :tax2_amt, :total, :tran_date, :tran_id, :use_multi_currency
    ].each do |field|
      expect(entry).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
        :account, :approval_status, :klass, :custom_form, :department, :entity,
        :location, :next_approver, :posting_period, :subsidiary
    ].each do |record_ref|
      expect(entry).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :script_id => 'custfield_amount'
        }
      }
      entry.custom_field_list = attributes
      expect(entry.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(entry.custom_field_list.custom_fields.length).to eql(1)
      expect(entry.custom_field_list.custfield_amount.attributes[:amount]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      entry.custom_field_list = custom_field_list
      expect(entry.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#expense_list' do
    it 'can be set from attributes' do
      attributes = {
        :expense => {

        }
      }
      entry.expense_list = attributes
      expect(entry.expense_list).to be_kind_of(NetSuite::Records::ExpenseReportExpenseList)
      expect(entry.expense_list.expense.length).to eql(1)
    end

    it 'can be set from a ExpenseReportExpenseList object' do
        expense_list = NetSuite::Records::ExpenseReportExpenseList.new
      entry.expense_list = expense_list
      expect(entry.expense_list).to eql(expense_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :accounting_approval => true }) }

      it 'returns a ExpenseReport instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::ExpenseReport, {:external_id => 1}], {}).and_return(response)
        expense = NetSuite::Records::ExpenseReport.get(:external_id => 1)
        expect(expense).to be_kind_of(NetSuite::Records::ExpenseReport)
        expect(expense.accounting_approval).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        binding.pry
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::ExpenseReport, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::ExpenseReport.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::ExpenseReport with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:entry) { NetSuite::Records::ExpenseReport.new(:approved => true) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([entry], {}).
            and_return(response)
        expect(entry.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([entry], {}).
            and_return(response)
        expect(entry.add).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:entry) { NetSuite::Records::ExpenseReport.new(:tran_id => '1234', :accounting_approval => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(entry.to_record).to eql({
        'tranEmp:tranId'   => '1234',
        'tranEmp:accountingApproval' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(entry.record_type).to eql('tranEmp:ExpenseReport')
    end
  end

end
