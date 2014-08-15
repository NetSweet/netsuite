require 'spec_helper'

describe NetSuite::Records::BillingScheduleMilestone do
  let(:milestone) { NetSuite::Records::BillingScheduleMilestone.new }

  it 'has the right fields' do
    [
      :comments, :milestone_actual_completion_date, :milestone_amount, 
      :milestone_completed, :milestone_date, :milestone_id
    ].each do |field|
      milestone.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :milestone_term, :project_task
    ].each do |record_ref|
      milestone.should have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::BillingScheduleMilestone.new(:comments => "foo")
    milestone = NetSuite::Records::BillingScheduleMilestone.new(record)
    milestone.should be_kind_of(NetSuite::Records::BillingScheduleMilestone)
    milestone.comments.should eql("foo")
  end

  describe '#to_record' do
    before do
      milestone.comments         = 'comment'
      milestone.milestone_amount = 1
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:comments'        => 'comment',
        'listAcct:milestoneAmount' => 1
      }
      milestone.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      milestone.record_type.should eql('listAcct:BillingScheduleMilestone')
    end
  end

end
