require 'spec_helper'

describe NetSuite::Records::PhoneCall do
  let(:phone_call) { NetSuite::Records::PhoneCall.new }

  it "has the right fields" do
    [:title, :message, :phone, :status, :priority, :start_date, :end_date, :completed_date, :timed_event, :access_level].each do |f|
      phone_call.should have_field(f)
    end
  end

  it 'has the right record refs' do
    [:assigned, :owner, :company, :contact].each do |rr|
      phone_call.should have_record_ref(rr)
    end
  end

  describe 'to_record' do
    it 'should be verified with our params' do
      fail 'Not Verified.'
    end
  end
end
