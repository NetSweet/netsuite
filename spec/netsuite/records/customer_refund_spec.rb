require 'spec_helper'

describe NetSuite::Records::CustomerRefund do
  let(:refund) { NetSuite::Records::CustomerRefund.new }

  # <element name="applyList" type="tranCust:CustomerRefundApplyList" minOccurs="0"/>
  # <element name="depositList" type="tranCust:CustomerRefundDepositList" minOccurs="0"/>

  it 'has all the right fields' do
    [
      :address, :balance, :cc_approved, :cc_expire_date, :cc_name, :cc_number, :cc_street, :cc_zip_code, :charge_it,
      :created_date, :currency_name, :debit_card_issue_no, :exchange_rate, :last_modified_date, :memo, :pn_ref_num, :status,
      :to_be_printed, :total, :tran_date, :tran_id, :valid_from
    ].each do |field|
      refund.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :ar_acct, :credit_card, :credit_card_processor, :custom_form, :customer, :department, :klass, :location,
      :payment_method, :posting_period, :subsidiary, :void_journal
    ].each do |record_ref|
      refund.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10
        }
      }
      refund.custom_field_list = attributes
      refund.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      refund.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      refund.custom_field_list = custom_field_list
      refund.custom_field_list.should eql(custom_field_list)
    end
  end

end
