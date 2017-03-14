require 'spec_helper'

describe NetSuite::Records::BillingScheduleMilestoneList do
  let(:list) { NetSuite::Records::BillingScheduleMilestoneList.new }
  let(:milestone) { NetSuite::Records::BillingScheduleMilestone.new }

  it 'can have milestones be added to it' do
    list.milestones << milestone
    milestone_list = list.milestones
    expect(milestone_list).to be_kind_of(Array)
    expect(milestone_list.length).to eql(1)
    milestone_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::BillingScheduleMilestone) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:billingScheduleMilestone' => []
      }
      expect(list.to_record).to eql(record)
    end
  end

end
