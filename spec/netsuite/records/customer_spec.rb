require 'spec_helper'

describe NetSuite::Records::Customer do
  let(:customer) { NetSuite::Records::Customer.new }

  it 'has all the right fields' do
    [
      :account_number, :aging, :alt_email, :alt_name, :alt_phone, :balance, :bill_pay,
      :buying_reason, :buying_time_frame, :campaign_category, :click_stream, :comments, :company_name,
      :consol_aging, :consol_balance, :consol_days_overdue, :consol_deposit_balance, :consol_overdue_balance,
      :consol_unbilled_orders, :contrib_pct, :credit_hold_override, :credit_limit,
      :date_created, :days_overdue, :default_address,
      :deposit_balance, :download_list, :email, :email_preference, :email_transactions, :end_date, :entity_id,
      :estimated_budget, :fax, :fax_transactions, :first_name, :first_visit, :give_access, :global_subscription_status,
      :group_pricing_list, :home_phone, :image, :is_budget_approved, :is_inactive, :is_person, :item_pricing_list, :keywords,
      :language, :last_modified_date, :last_name, :last_page_visited, :last_visit, :middle_name, :mobile_phone,
      :opening_balance, :opening_balance_account, :opening_balance_date, :overdue_balance,
      :password, :password2, :phone, :phonetic_name, :pref_cc_processor,:print_on_check_as,
      :print_transactions, :referrer, :reminder_days, :representing_subsidiary, :require_pwd_change, :resale_number,
      :sales_group, :sales_readiness, :salutation, :send_email, :ship_complete,
      :stage, :start_date, :sync_partner_teams, :tax_exempt, :taxable,
      :third_party_acct, :third_party_country, :third_party_zipcode, :title, :unbilled_orders, :url,
      :vat_reg_number, :visits, :web_lead
    ].each do |field|
      expect(customer).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :access_role, :currency, :custom_form, :entity_status, :partner, :sales_rep, :terms, :parent, :territory, :shipping_item, :tax_item
    ].each do |record_ref|
      expect(customer).to have_record_ref(record_ref)
    end
  end

  # TODO test contact_roles_list

  describe '#addressbook_list' do
    it 'can be set from attributes' do
      customer.addressbook_list = {
        :addressbook => {
          :addr1            => '123 Happy Lane',
          :addr_text        => "123 Happy Lane\nLos Angeles CA 90007",
          :city             => 'Los Angeles',
          :country          => '_unitedStates',
          :default_billing  => true,
          :default_shipping => true,
          :internal_id      => '567',
          :is_residential   => false,
          :label            => '123 Happy Lane',
          :override         => false,
          :state            => 'CA',
          :zip              => '90007'
        }
      }
      expect(customer.addressbook_list).to be_kind_of(NetSuite::Records::CustomerAddressbookList)
      expect(customer.addressbook_list.addressbook.length).to eql(1)
    end

    it 'can be set from a CustomerAddressbookList object' do
      customer_addressbook_list = NetSuite::Records::CustomerAddressbookList.new
      customer.addressbook_list = customer_addressbook_list
      expect(customer.addressbook_list).to eql(customer_addressbook_list)
    end
  end

  describe '#credit_cards_list' do
    it 'can be set from attributes' do
      customer.credit_cards_list = {
        :credit_cards => {
          :internal_id       => '1234567',
          :cc_default        => true,
          :cc_expire_date    => '2099-12-01T00:00:00.000-08:00'
        }
      }

      expect(customer.credit_cards_list).to be_kind_of(NetSuite::Records::CustomerCreditCardsList)
      expect(customer.credit_cards_list.credit_cards.length).to eql(1)
    end

    it 'can be set from a CustomerCreditCardsList object' do
      customer_credit_cards_list = NetSuite::Records::CustomerCreditCardsList.new
      customer.credit_cards_list = customer_credit_cards_list
      expect(customer.credit_cards_list).to eql(customer_credit_cards_list)
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
      customer.custom_field_list = attributes
      expect(customer.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(customer.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      customer.custom_field_list = custom_field_list
      expect(customer.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#subscriptions_list' do
    it 'can be set from attributes' do
      customer.subscriptions_list = {
        subscriptions: [
          {
            :subscribed         => true
          }
        ]
      }
      expect(customer.subscriptions_list).to be_kind_of(NetSuite::Records::CustomerSubscriptionsList)
      expect(customer.subscriptions_list.subscriptions.length).to eql(1)
    end

    it 'can be set from a CustomerSubscriptionsList object' do
      customer_subscriptions_list = NetSuite::Records::CustomerSubscriptionsList.new
      customer.subscriptions_list = customer_subscriptions_list
      expect(customer.subscriptions_list).to eql(customer_subscriptions_list)
    end
  end


  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Customer, {:external_id => 1}], {}).and_return(response)
        customer = NetSuite::Records::Customer.get(:external_id => 1)
        expect(customer).to be_kind_of(NetSuite::Records::Customer)
        expect(customer.is_person).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Customer, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Customer.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Customer with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:customer) { NetSuite::Records::Customer.new(:entity_id => 'TEST CUSTOMER', :is_person => true) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([customer], {}).
            and_return(response)
        expect(customer.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([customer], {}).
            and_return(response)
        expect(customer.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([customer], {}).
            and_return(response)
        expect(customer.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([customer], {}).
            and_return(response)
        expect(customer.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:customer) { NetSuite::Records::Customer.new(:entity_id => 'TEST CUSTOMER', :is_person => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(customer.to_record).to eql({
        'listRel:entityId' => 'TEST CUSTOMER',
        'listRel:isPerson' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(customer.record_type).to eql('listRel:Customer')
    end
  end

  describe '.upsert_list' do
    before { savon.mock! }
    after { savon.unmock! }

    context 'with one customer' do
      before do
        savon.expects(:upsert_list).with(:message =>
          {
            'record' => [{
              'listRel:entityId'    => 'Target',
              'listRel:companyName' => 'Target',
              '@xsi:type' => 'listRel:Customer',
              '@externalId' => 'ext2'
            }]
        }).returns(File.read('spec/support/fixtures/upsert_list/upsert_list_one_customer.xml'))
      end

      it 'returns collection with one Customer instances populated with the data from the response object' do
        customers = NetSuite::Records::Customer.upsert_list([
          {
            external_id: 'ext2',
            entity_id: 'Target',
            company_name: 'Target'
          }
        ])
        shutter_fly = customers[0]
        expect(shutter_fly).to be_kind_of(NetSuite::Records::Customer)
        expect(shutter_fly.entity_id).to eq('Target')
        expect(shutter_fly.internal_id).to eq('974')
      end
    end

    context 'with two customers' do
      before do
        savon.expects(:upsert_list).with(:message =>
          {
            'record' => [{
                'listRel:entityId'    => 'Shutter Fly',
                'listRel:companyName' => 'Shutter Fly, Inc.',
                '@xsi:type' => 'listRel:Customer',
                '@externalId' => 'ext1'
              },
              {
                'listRel:entityId'    => 'Target',
                'listRel:companyName' => 'Target',
                '@xsi:type' => 'listRel:Customer',
                '@externalId' => 'ext2'
              }
            ]
        }).returns(File.read('spec/support/fixtures/upsert_list/upsert_list_customers.xml'))
      end

      it 'returns collection of Customer instances populated with the data from the response object' do
        customers = NetSuite::Records::Customer.upsert_list([
          {
            external_id: 'ext1',
            entity_id: 'Shutter Fly',
            company_name: 'Shutter Fly, Inc.'
          },
          {
            external_id: 'ext2',
            entity_id: 'Target',
            company_name: 'Target'
          }
        ])
        shutter_fly = customers[0]
        expect(shutter_fly).to be_kind_of(NetSuite::Records::Customer)
        expect(shutter_fly.entity_id).to eq('Shutter Fly')
        expect(shutter_fly.internal_id).to eq('970')
      end
    end
  end
end
