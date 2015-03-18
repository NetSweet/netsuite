require 'spec_helper'

describe NetSuite::Records::Employee do
  let(:employee) { NetSuite::Records::Employee.new }

  it 'has all the right fields' do
    [
      :account_number, :alien_number, :approval_limit, :bill_pay, :birth_date,
      :comments, :date_created, :direct_deposit, :eligible_for_commission,
      :email, :employee_status, :employee_type, :entity_id, :expense_limit,
      :fax, :first_name, :hire_date, :home_phone, :is_inactive, :is_job_resource,
      :job_description, :labor_cost, :last_modified_date, :last_name, :middle_name,
      :mobile_phone, :next_review_date, :office_phone, :pay_frequency, :phone,
      :phonetic_name, :purchase_order_approval_limit, :purchase_order_approver,
      :purchase_order_limit, :release_date, :resident_status, :salutation,
      :social_security_number, :title, :visa_exp_date, :visa_type
    ].each do |field|
      expect(employee).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    %i(
      currency department location subsidiary
    ).each do |record_ref|
      expect(employee).to have_record_ref(record_ref)
    end
  end
end
