require 'spec_helper'

describe NetSuite::Records::CustomerPayment do
  let(:payment) { NetSuite::Records::CustomerPayment.new }

#  <element name="applyList" type="tranCust:CustomerPaymentApplyList" minOccurs="0"/>
#  <element name="creditList" type="tranCust:CustomerPaymentCreditList" minOccurs="0"/>
#  <element name="depositList" type="tranCust:CustomerPaymentDepositList" minOccurs="0"/>
  it 'has all the right fields' do
    [
      :applied, :auth_code, :auto_apply, :balance, :cc_approved, :cc_avs_street_match, :cc_avs_zip_match, :cc_expire_date,
      :cc_name, :cc_number, :cc_security_code, :cc_security_code_match, :cc_street, :cc_zip_code, :charge_it, :check_num,
      :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :ignore_avs, :last_modified_date, :memo, :payment,
      :pending, :pn_ref_num, :status, :three_d_status_code, :total, :tran_date, :unapplied, :undep_funds, :valid_from
    ].each do |field|
      payment.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass, :location, :payment_method, :posting_period, :subsidiary
    ].each do |record_ref|
      payment.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10
        }
      }
      payment.custom_field_list = attributes
      payment.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      payment.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      payment.custom_field_list = custom_field_list
      payment.custom_field_list.should eql(custom_field_list)
    end
  end

end
