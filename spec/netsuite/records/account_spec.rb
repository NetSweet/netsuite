require 'spec_helper'

describe NetSuite::Records::Account do
  let(:account) { NetSuite::Records::Account.new }

  it 'has all the right fields' do
    [
      :acct_name, :acct_number, :acct_type, :cash_flow_rate, :cur_doc_num, :description, :eliminate, :exchange_rate,
      :general_rate, :include_children, :inventory, :is_inactive, :opening_balance, :revalue, :tran_date
    ].each do |field|
      expect(account).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :billable_expenses_acct, :category1099misc, :currency, :deferral_acct, :department, :klass, :location, :parent
    ].each do |record_ref|
      expect(account).to have_record_ref(record_ref)
    end
  end

  describe '#subsidiary_list' do
    it 'can be set from attributes'
    it 'can be set from a RecordRefList object'
  end

  describe '#translations_list' do
    it 'can be set from attributes'
    it 'can be set from an AccountTranslationList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :acct_name => 'Account 1' }) }

      it 'returns a Account instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Account, {:external_id => 1}], {}).and_return(response)
        account = NetSuite::Records::Account.get(:external_id => 1)
        expect(account).to be_kind_of(NetSuite::Records::Account)
        expect(account.acct_name).to eql('Account 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Account, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Account.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
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
        expect(NetSuite::Actions::Add).to receive(:call).
            with([account], {}).
            and_return(response)
        expect(account.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        account = NetSuite::Records::Account.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([account], {}).
            and_return(response)
        expect(account.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        account = NetSuite::Records::Account.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([account], {}).
            and_return(response)
        expect(account.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        account = NetSuite::Records::Account.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([account], {}).
            and_return(response)
        expect(account.delete).to be_falsey
      end
    end
  end

end
