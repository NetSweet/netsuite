require 'spec_helper'

describe NetSuite::Records::Customer do
  let(:customer) { NetSuite::Records::Customer.new }

  it 'has all the right fields' do
    [
      :access_role, :account_number, :aging, :alt_email, :alt_name, :alt_phone, :balance, :bill_pay,
      :buying_reason, :buying_time_frame, :campaign_category, :click_stream, :comments, :company_name,
      :consol_aging, :consol_balance, :consol_days_overdue, :consol_deposit_balance, :consol_overdue_balance,
      :consol_unbilled_orders, :contact_roles_list, :contrib_pct, :credit_cards_list, :credit_hold_override, :credit_limit,
      :currency, :currency_list, :date_created, :days_overdue, :default_address,
      :deposit_balance, :download_list, :email, :email_preference, :email_transactions, :end_date, :entity_id,
      :estimated_budget, :fax, :fax_transactions, :first_name, :first_visit, :give_access, :global_subscription_status,
      :group_pricing_list, :home_phone, :image, :is_budget_approved, :is_inactive, :is_person, :item_pricing_list, :keywords,
      :language, :last_modified, :last_name, :last_page_visited, :last_visit, :lead_source, :middle_name, :mobile_phone,
      :opening_balance, :opening_balance_account, :opening_balance_date, :overdue_balance, :parent, :partner, :partners_list,
      :password, :password_2, :phone, :phonetic_name, :pref_cc_processor, :price_level, :print_on_check_as,
      :print_transactions, :referrer, :reminder_days, :representing_subsidiary, :require_pwd_change, :resale_number,
      :sales_group, :sales_readiness, :sales_rep, :sales_team_list, :salutation, :send_email, :ship_complete, :shipping_item,
      :stage, :start_date, :subscriptions_list, :subsidiary, :sync_partner_teams, :tax_exempt, :tax_item, :taxable,
      :territory, :third_party_acct, :third_party_country, :third_party_zipcode, :title, :unbilled_orders, :url,
      :vat_reg_number, :visits, :web_lead
    ].each do |field|
      customer.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :custom_form, :entity_status, :category, :terms
    ].each do |record_ref|
      customer.should have_record_ref(record_ref)
    end
  end

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
      customer.addressbook_list.should be_kind_of(NetSuite::Records::CustomerAddressbookList)
      customer.addressbook_list.addressbooks.length.should eql(1)
    end

    it 'can be set from a CustomerAddressbookList object' do
      customer_addressbook_list = NetSuite::Records::CustomerAddressbookList.new
      customer.addressbook_list = customer_addressbook_list
      customer.addressbook_list.should eql(customer_addressbook_list)
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
      customer.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      customer.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      customer.custom_field_list = custom_field_list
      customer.custom_field_list.should eql(custom_field_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Customer, :external_id => 1).and_return(response)
        customer = NetSuite::Records::Customer.get(:external_id => 1)
        customer.should be_kind_of(NetSuite::Records::Customer)
        customer.is_person.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Customer, :external_id => 1).and_return(response)
        lambda {
          NetSuite::Records::Customer.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Customer with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:customer) { NetSuite::Records::Customer.new(:entity_id => 'TEST CUSTOMER', :is_person => true) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with(customer).
            and_return(response)
        customer.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with(customer).
            and_return(response)
        customer.add.should be_false
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with(customer).
            and_return(response)
        customer.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with(customer).
            and_return(response)
        customer.delete.should be_false
      end
    end
  end

  describe '#to_record' do
    let(:customer) { NetSuite::Records::Customer.new(:entity_id => 'TEST CUSTOMER', :is_person => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      customer.to_record.should eql({
        'listRel:entityId' => 'TEST CUSTOMER',
        'listRel:isPerson' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      customer.record_type.should eql('listRel:Customer')
    end
  end

end
