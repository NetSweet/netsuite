require 'spec_helper'

describe NetSuite::Records::Vendor do
  let(:vendor) { NetSuite::Records::Vendor.new }

  it 'has all the right fields' do
    [
        :account_number, :alt_email, :alt_name, :alt_phone, :balance,
        :balance_primary, :bcn, :bill_pay, :comments, :company_name, :credit_limit,
        :currency_list, :date_created, :default_address, :eligible_for_commission,
        :email, :email_preference, :email_transactions, :entity_id, :fax, :fax_transactions,
        :first_name, :give_access, :global_subscription_status, :home_phone, :is1099_eligible,
        :is_accountant, :is_inactive, :is_job_resource_vend, :is_person, :labor_cost,
        :last_modified_date, :last_name, :legal_name, :middle_name, :mobile_phone, :opening_balance,
        :opening_balance_date, :password, :password2, :phone, :phonetic_name, :pricing_schedule_list,
        :print_on_check_as, :print_transactions, :require_pwd_change, :roles_list, :salutation,
        :send_email, :subscriptions_list, :tax_id_num, :title, :unbilled_orders, :unbilled_orders_primary,
        :url, :vat_reg_number
    ].each do |field|
      vendor.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
        :custom_form, :category, :image, :subsidiary, :representing_subsidiary,
        :expense_account, :payables_account, :terms, :opening_balance_account, :currency, :work_calendar,
        :tax_item
    ].each do |record_ref|
      vendor.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes               = {
          :custom_field => {
              :value       => 10,
              :internal_id => 'custfield_something'
          }
      }
      vendor.custom_field_list = attributes
      vendor.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      vendor.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list        = NetSuite::Records::CustomFieldList.new
      vendor.custom_field_list = custom_field_list
      vendor.custom_field_list.should eql(custom_field_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns a Vendor instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Vendor, { :external_id => 1 }], {}).and_return(response)
        vendor = NetSuite::Records::Vendor.get(:external_id => 1)
        vendor.should be_kind_of(NetSuite::Records::Vendor)
        vendor.is_person.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::Vendor, { :external_id => 1 }], {}).and_return(response)
        lambda {
          NetSuite::Records::Vendor.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
                             /NetSuite::Records::Vendor with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:vendor) { NetSuite::Records::Vendor.new(:entity_id => 'TEST VENDOR', :is_person => true) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with([vendor], {}).
            and_return(response)
        vendor.add.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with([vendor], {}).
            and_return(response)
        vendor.add.should be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([vendor], {}).
            and_return(response)
        vendor.delete.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([vendor], {}).
            and_return(response)
        vendor.delete.should be_falsey
      end
    end
  end

  describe '#to_record' do
    let(:vendor) { NetSuite::Records::Vendor.new(:entity_id => 'TEST VENDOR', :is_person => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      vendor.to_record.should eql({
                                        'listRel:entityId' => 'TEST VENDOR',
                                        'listRel:isPerson' => true
                                    })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      vendor.record_type.should eql('listRel:Vendor')
    end
  end
end
