require 'spec_helper'

describe NetSuite::Customer do
  let(:customer) { NetSuite::Customer.new }

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(1).and_return(response)
        customer = NetSuite::Customer.get(1)
        customer.should be_kind_of(NetSuite::Customer)
        customer.is_person.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(1).and_return(response)
        lambda {
          NetSuite::Customer.get(1)
        }.should raise_error(NetSuite::RecordNotFound, 'NetSuite::Customer with ID=1 could not be found')
      end
    end
  end

  describe '#add' do
    let(:test_data) { { :entity_name => 'TEST CUSTOMER', :is_person => true } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with(test_data).
            and_return(response)
        customer = NetSuite::Customer.new(test_data)
        customer.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }
      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with(test_data).
            and_return(response)
        customer = NetSuite::Customer.new(test_data)
        customer.add.should be_false
      end
    end
  end

  it 'has all the right fields' do
    [
      :custom_form, :entity_id, :alt_name, :is_person, :phonetic_name, :salutation, :first_name,
      :middle_name, :last_name, :company_name, :entity_status, :parent, :phone, :fax, :email, :url,
      :default_address, :is_inactive, :category, :title, :print_on_check_as, :alt_phone, :home_phone,
      :mobile_phone, :alt_email, :language, :comments, :date_created, :image, :email_preference,
      :subsidiary, :representing_subsidiary, :sales_rep, :territory, :contrib_pct, :partner,
      :sales_group, :vat_reg_number, :account_number, :tax_exempt, :terms, :credit_limit,
      :credit_hold_override, :balance, :overdue_balance, :days_overdue, :unbilled_orders,
      :consol_unbilled_orders, :consol_overdue_balance, :consol_deposit_balance, :consol_balance,
      :consol_aging, :consol_days_overdue, :price_level, :currency, :pref_cc_processor, :deposit_balance,
      :ship_complete, :taxable, :tax_item, :resale_number, :aging, :start_date, :end_date, :reminder_days,
      :shipping_item, :third_party_acct, :third_party_zipcode, :third_party_country, :give_access,
      :estimated_budget, :access_role, :send_email, :password, :password_2, :require_pwd_change,
      :campaign_category, :lead_source, :web_lead, :referrer, :keywords, :click_stream,
      :last_page_visited, :visits, :first_visit, :last_visit, :bill_pay, :opening_balance, :last_modified,
      :opening_balance_date, :opening_balance_account, :stage, :email_transactions, :print_transactions,
      :fax_transactions, :sync_partner_teams, :is_budget_approved, :global_subscription_status,
      :sales_readiness, :sales_team_list, :buying_reason, :download_list, :buying_time_frame,
      :addressbook_list, :subscriptions_list, :contact_roles_list, :currency_list, :credit_cards_list,
      :partners_list, :group_pricing_list, :item_pricing_list, :custom_field_list
    ].each do |field|
      customer.should have_field(field)
    end
  end

end
