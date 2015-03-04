require 'spec_helper'

describe NetSuite::Status do
  let(:success_status) do
    NetSuite::Status.new(:@is_success => "true")
  end

  let(:error_status) do
    NetSuite::Status.new(
      :status_detail => { :code=>"SOME_ERROR_CODE", :message=>"Some error message.", :@type=>"ERROR" },
      :@is_success => "false"
    )
  end

  let(:warnings_status) do
    NetSuite::Status.new(
      :status_detail => [
        { :code=>"SOME_WARNING_CODE_1", :message=>"Some warning message.", :@type=>"WARNING" },
        { :code=>"SOME_WARNING_CODE_2", :message=>"Some other warning message.", :@type=>"WARNING" }
      ],
      :@is_success => "true"
    )
  end

  describe '#initialize' do
    it 'sets the status so that success? works properly' do
      expect(success_status.success?).to be_truthy
      expect(error_status.success?).to be_falsey
    end

    it 'handle missing status details' do
      expect(success_status.details).to be_empty
    end

    it 'creates the status details when available' do
      details = error_status.details
      expect(details).to be_kind_of(Array)
      expect(details.length).to eql(1)
      expect(details[0]).to be_kind_of(NetSuite::StatusDetail)
      expect(details[0].code).to eql('SOME_ERROR_CODE')
      expect(details[0].message).to eql('Some error message.')
    end

    it 'handles multiple status details' do
      details = warnings_status.details
      expect(details).to be_kind_of(Array)
      expect(details.length).to eql(2)
      expect(details[0].code).to eql('SOME_WARNING_CODE_1')
      expect(details[0].message).to eql('Some warning message.')
      expect(details[1].code).to eql('SOME_WARNING_CODE_2')
      expect(details[1].message).to eql('Some other warning message.')
    end
  end
end

