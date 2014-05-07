require 'spec_helper'

describe NetSuite::Records::CreditMemo do
  let(:memo) { NetSuite::Records::CreditMemo.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :applied, :auto_apply, :balance, :bill_address,
      :contrib_pct, :created_date, :currency_name, :deferred_revenue, :discount_rate, :discount_total, :email, :est_gross_profit,
      :est_gross_profit_percent, :exchange_rate, :exclude_commission, :fax, :gift_cert_applied, :gift_cert_available,
      :gift_cert_total, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :is_taxable, :last_modified_date, :memo,
      :message, :on_credit_hold, :other_ref_num, :recognized_revenue, :rev_rec_on_rev_commitment, :sales_effective_date,
      :shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :source, :status, :sub_total, :sync_partner_teams,
      :sync_sales_teams, :tax2_total, :tax_rate, :tax_total, :to_be_emailed, :to_be_faxed, :to_be_printed, :total,
      :total_cost_estimate, :tran_date, :tran_id, :tran_is_vsoe_bundle, :unapplied, :vat_reg_num, :vsoe_auto_calc
    ].each do |field|
      memo.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :bill_address_list, :created_from, :custom_form, :department, :discount_item, :entity, :gift_cert,
      :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel, :partner, :posting_period, :promo_code,
      :sales_group, :sales_rep, :ship_method, :shipping_tax_code, :subsidiary, :tax_item
    ].each do |record_ref|
      memo.should have_record_ref(record_ref)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      memo.item_list = attributes
      memo.item_list.should be_kind_of(NetSuite::Records::CreditMemoItemList)
      memo.item_list.items.length.should eql(1)
    end

    it 'can be set from a CreditMemoItemList object' do
      item_list = NetSuite::Records::CreditMemoItemList.new
      memo.item_list = item_list
      memo.item_list.should eql(item_list)
    end
  end

  describe '#apply_list' do
    it 'can be set from attributes' do
      attributes = {
        :apply => {
          :job => 'something'
        }
      }
      memo.apply_list = attributes
      memo.apply_list.should be_kind_of(NetSuite::Records::CreditMemoApplyList)
      memo.apply_list.applies.length.should eql(1)
    end

    it 'can be set from a CreditMemoApplyList object' do
      apply_list = NetSuite::Records::CreditMemoApplyList.new
      memo.apply_list = apply_list
      memo.apply_list.should eql(apply_list)
    end
  end

  describe '#transaction_bill_address' do
    it 'can be set from attributes'
    it 'can be set from a BillAddress object'
  end

  describe '#revenue_status' do
    it 'can be set from attributes'
    it 'can be set from a RevenueStatus object'
  end

  describe '#sales_team_list' do
    it 'can be set from attributes'
    it 'can be set from a CreditMemoSalesTeamList object'
  end

  describe '#partners_list' do
    it 'can be set from attributes'
    it 'can be set from a CreditMemoPartnersList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :alt_shipping_cost => 100 }) }

      it 'returns a CreditMemo instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::CreditMemo, {:external_id => 1}], {}).and_return(response)
        memo = NetSuite::Records::CreditMemo.get(:external_id => 1)
        memo.should be_kind_of(NetSuite::Records::CreditMemo)
        memo.alt_shipping_cost.should eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::CreditMemo, {:external_id => 1}], {}).and_return(response)
        lambda {
          NetSuite::Records::CreditMemo.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CreditMemo with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized credit memo from the customer entity' do
        NetSuite::Actions::Initialize.should_receive(:call).with([NetSuite::Records::CreditMemo, customer], {}).and_return(response)
        invoice = NetSuite::Records::CreditMemo.initialize(customer)
        invoice.should be_kind_of(NetSuite::Records::CreditMemo)
      end
    end

    context 'when the response is unsuccessful' do
      pending
    end
  end

  describe '#add' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        memo = NetSuite::Records::CreditMemo.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with([memo], {}).
            and_return(response)
        memo.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        memo = NetSuite::Records::CreditMemo.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with([memo], {}).
            and_return(response)
        memo.add.should be_false
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        memo = NetSuite::Records::CreditMemo.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([memo], {}).
            and_return(response)
        memo.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        memo = NetSuite::Records::CreditMemo.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with([memo], {}).
            and_return(response)
        memo.delete.should be_false
      end
    end
  end

  describe '#to_record' do
    before do
      memo.email   = 'something@example.com'
      memo.tran_id = '4'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:email'  => 'something@example.com',
        'tranCust:tranId' => '4'
      }
      memo.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      memo.record_type.should eql('tranCust:CreditMemo')
    end
  end

end
