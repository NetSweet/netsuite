require 'spec_helper'

describe NetSuite::Records::PhoneCall do
  let(:phone_call) { NetSuite::Records::PhoneCall.new }

  it "has the right fields" do
    [:title, :message, :phone, :status, :priority, :start_date, :end_date, :completed_date, :timed_event, :access_level].each do |f|
      expect(phone_call).to have_field(f)
    end
  end

  it 'has the right record refs' do
    [:assigned, :owner, :company, :contact].each do |rr|
      expect(phone_call).to have_record_ref(rr)
    end
  end
end
