require 'spec_helper'

describe NetSuite::Records::Partner do
  let(:partner) { NetSuite::Records::Partner.new }

  it 'has all the right fields' do
    [
        :phone, :home_phone, :first_name, :last_name, :alt_name, :is_inactive, :email, :give_access,
        :partner_code, :is_person, :company_name, :eligible_for_commission, :entity_id, :last_modified_date,
        :date_created, :title, :mobile_phone, :comments, :middle_name, :send_email, :password, :password2
    ].each do |field|
      expect(partner).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
        :klass, :access_role, :department, :subsidiary
    ].each do |record_ref|
      expect(partner).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :account_number => 7 }) }

      it 'returns an Partner instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Partner, { :external_id => 1 }], {}).and_return(response)
        Partner = NetSuite::Records::Partner.get(:external_id => 1)
        expect(Partner).to be_kind_of(NetSuite::Records::Partner)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Partner, { :external_id => 1 }], {}).and_return(response)
        expect {
          NetSuite::Records::Partner.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
                         /NetSuite::Records::Partner with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:partner) { NetSuite::Records::Partner.new(:email => 'dale.cooper@example.com') }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
                                            with([partner], {}).
                                            and_return(response)
        expect(partner.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
                                            with([partner], {}).
                                            and_return(response)
        expect(partner.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
                                               with([partner], {}).
                                               and_return(response)
        expect(partner.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
                                               with([partner], {}).
                                               and_return(response)
        expect(partner.delete).to be_falsey
      end
    end
  end

  describe '.update' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :email => 'leland.palmer@example.com' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Partner, { :internal_id => 1, :email => 'leland.palmer@example.com' }], {}).and_return(response)
        partner = NetSuite::Records::Partner.new(:internal_id => 1)
        expect(partner.update(:email => 'leland.palmer@example.com')).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Update).to receive(:call).with([NetSuite::Records::Partner, { :internal_id => 1, :account_number => 7 }], {}).and_return(response)
        partner = NetSuite::Records::Partner.new(:internal_id => 1)
        expect(partner.update(:account_number => 7)).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:partner) { NetSuite::Records::Partner.new(:email => 'bob@example.com') }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(partner.to_record).to eql({ 'listRel:email' => 'bob@example.com' })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(partner.record_type).to eql('listRel:Partner')
    end
  end

  it 'has the right record_refs' do
    [
        :klass, :access_role, :department, :subsidiary
    ].each do |record_ref|
      expect(partner).to have_record_ref(record_ref)
    end
  end
end
