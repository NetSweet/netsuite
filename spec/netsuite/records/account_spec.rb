require 'spec_helper'

describe NetSuite::Records::Account do
  let(:account) { NetSuite::Records::Account.new }

# <element name="subsidiaryList" type="platformCore:RecordRefList" minOccurs="0"/>
# <element name="translationsList" type="listAcct:AccountTranslationList" minOccurs="0"/>
# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>
  it 'has all the right fields' do
    [
      :acct_name, :acct_number, :acct_type, :cash_flow_rate, :cur_doc_num, :description, :eliminate, :exchange_rate,
      :general_rate, :include_children, :inventory, :is_inactive, :opening_balance, :revalue, :tran_date
    ].each do |field|
      account.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :billable_expenses_acct, :category1099misc, :currency, :deferral_acct, :department, :klass, :location, :parent
    ].each do |record_ref|
      account.should have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :acct_name => 'Account 1' }) }

      it 'returns a Account instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Account, :external_id => 1).and_return(response)
        account = NetSuite::Records::Account.get(:external_id => 1)
        account.should be_kind_of(NetSuite::Records::Account)
        account.acct_name.should eql('Account 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Account, :external_id => 1).and_return(response)
        lambda {
          NetSuite::Records::Account.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Account with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :acct_name => 'Test Account', :description => 'An example account' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        account = NetSuite::Records::Account.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(account).
            and_return(response)
        account.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        account = NetSuite::Records::Account.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(account).
            and_return(response)
        account.add.should be_false
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        account = NetSuite::Records::Account.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with(account).
            and_return(response)
        account.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        account = NetSuite::Records::Account.new(test_data)
        NetSuite::Actions::Delete.should_receive(:call).
            with(account).
            and_return(response)
        account.delete.should be_false
      end
    end
  end

end
