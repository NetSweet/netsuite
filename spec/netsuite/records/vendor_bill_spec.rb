require 'spec_helper'

describe NetSuite::Records::VendorBill do
  let(:bill) { NetSuite::Records::VendorBill.new(external_id: 'some id') }
  let(:vendor) { NetSuite::Records::Vendor.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :@internal_id => '1', :@external_id =>'some id' }) }

  it 'has all the right fields' do
    [
      :created_date, :credit_limit, :currency_name, :discount_amount, :discount_date, :due_date, :exchange_rate,
      :landed_costs_list, :landed_cost_method, :landed_cost_per_line, :last_modified_date, :memo, :tax_total,
      :tax_2_total, :transaction_number, :tran_date, :tran_id, :user_total, :vat_reg_num
    ].each do |field|
      expect(bill).to have_field(field)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :status
    ].each do |field|
      expect(NetSuite::Records::VendorBill).to have_read_only_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :custom_form, :account, :entity, :subsidiary, :approval_status, :next_approver, :posting_period, :terms,
      :currency, :klass, :department, :location
    ].each do |record_ref|
      expect(bill).to have_record_ref(record_ref)
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
      bill.custom_field_list = attributes
      expect(bill.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(bill.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      bill.custom_field_list = custom_field_list
      expect(bill.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      bill.item_list = attributes
      expect(bill.item_list).to be_kind_of(NetSuite::Records::VendorBillItemList)
      expect(bill.item_list.items.length).to eql(1)
    end

    it 'can be set from a VendorBillItemList object' do
      item_list = NetSuite::Records::VendorBillItemList.new
      bill.item_list = item_list
      expect(bill.item_list).to eql(item_list)
    end
  end

  describe '#expense_list' do
    it 'can be set from attributes' do
      attributes = {
        :expense => {
          :gross_amt => 10
        }
      }
      bill.expense_list = attributes
      expect(bill.expense_list).to be_kind_of(NetSuite::Records::VendorBillExpenseList)
      expect(bill.expense_list.expenses.length).to eql(1)
    end

    it 'can be set from a VendorBillExpenseList object' do
      expense_list = NetSuite::Records::VendorBillExpenseList.new
      bill.expense_list = expense_list
      expect(bill.expense_list).to eql(expense_list)
    end
  end

  describe '#purchase_order_list' do
    it 'can be set from attributes' do
      attributes = {
        :record_ref => {
          :internal_id => 'some id',
          :value => 'some value'
        }
      }
      bill.purchase_order_list = attributes
      expect(bill.purchase_order_list).to be_kind_of(NetSuite::Records::RecordRefList)
      expect(bill.purchase_order_list.record_ref.length).to eql(1)
      expect(bill.purchase_order_list.record_ref[0].value).to eq('some value')
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      it 'returns an VendorBill instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorBill, external_id: 'some id'], {}).and_return(response)
        bill = NetSuite::Records::VendorBill.get(external_id: 'some id')
        expect(bill).to be_kind_of(NetSuite::Records::VendorBill)
        expect(bill.internal_id).to eq('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorBill, external_id: 'some id'], {}).and_return(response)
        expect {
          NetSuite::Records::VendorBill.get(external_id: 'some id')
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::VendorBill with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized vendor bill from the vendor entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::VendorBill, vendor], {}).and_return(response)
        bill = NetSuite::Records::VendorBill.initialize(vendor)
        expect(bill).to be_kind_of(NetSuite::Records::VendorBill)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a InitializationError exception' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::VendorBill, vendor], {}).and_return(response)
        expect {
          NetSuite::Records::VendorBill.initialize(vendor)
        }.to raise_error(NetSuite::InitializationError,
                         /NetSuite::Records::VendorBill.initialize with .+ failed./)
      end
    end
  end

  describe '#add' do
    context 'when the response is successful' do
      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).with([bill], {}).and_return(response)
        expect(bill.add).to be_truthy
        expect(bill.internal_id).to eq('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).with([bill], {}).and_return(response)
        expect(bill.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).with([bill], {}).and_return(response)
        expect(bill.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).with([bill], {}).and_return(response)
        expect(bill.delete).to be_falsey
      end
    end
  end
end
