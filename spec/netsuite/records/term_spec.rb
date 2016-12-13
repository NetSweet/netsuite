require 'spec_helper'

describe NetSuite::Records::Term do
  let(:term) { NetSuite::Records::Term.new }

  it 'has all the right fields' do
    [
      :name, :date_driven, :days_until_net_due, :discount_percent, :days_until_expiry, :day_of_month_net_due,
      :due_next_month_if_within_days, :discount_percent_date_driven, :day_discount_expires, :preferred, :is_inactive
    ].each do |field|
      expect(term).to have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :name => 'Term 1' }) }

      it 'returns a Term instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Term, {:external_id => 1}], {}).and_return(response)
        term = NetSuite::Records::Term.get(:external_id => 1)
        expect(term).to be_kind_of(NetSuite::Records::Term)
        expect(term.name).to eql('Term 1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Term, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Term.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Term with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :name => 'Test Term' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        term = NetSuite::Records::Term.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([term], {}).
            and_return(response)
        expect(term.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        term = NetSuite::Records::Term.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([term], {}).
            and_return(response)
        expect(term.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response)  { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        term = NetSuite::Records::Term.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([term], {}).
            and_return(response)
        expect(term.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        term = NetSuite::Records::Term.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([term], {}).
            and_return(response)
        expect(term.delete).to be_falsey
      end
    end
  end

end
