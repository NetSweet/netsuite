require 'spec_helper'

describe NetSuite::Records::BillingScheduleMilestoneList do
  let(:list) { NetSuite::Records::BillingScheduleMilestoneList.new }
  let(:milestone) { NetSuite::Records::BillingScheduleMilestone.new }

  it 'can have milestones be added to it' do
    list.milestones << milestone
    milestone_list = list.milestones
    milestone_list.should be_kind_of(Array)
    milestone_list.length.should eql(1)
    milestone_list.each { |i| i.should be_kind_of(NetSuite::Records::BillingScheduleMilestone) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:billingScheduleMilestone' => []
      }
      list.to_record.should eql(record)
    end
  end

end
