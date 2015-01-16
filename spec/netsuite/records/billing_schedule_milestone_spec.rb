require 'spec_helper'

describe NetSuite::Records::BillingScheduleMilestone do
  let(:milestone) { NetSuite::Records::BillingScheduleMilestone.new }

  it 'has the right fields' do
    [
      :comments, :milestone_actual_completion_date, :milestone_amount, 
      :milestone_completed, :milestone_date, :milestone_id
    ].each do |field|
      expect(milestone).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :milestone_term, :project_task
    ].each do |record_ref|
      expect(milestone).to have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::BillingScheduleMilestone.new(:comments => "foo")
    milestone = NetSuite::Records::BillingScheduleMilestone.new(record)
    expect(milestone).to be_kind_of(NetSuite::Records::BillingScheduleMilestone)
    expect(milestone.comments).to eql("foo")
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
      expect(milestone.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(milestone.record_type).to eql('listAcct:BillingScheduleMilestone')
    end
  end

end
