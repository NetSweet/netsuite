require 'spec_helper'

describe NetSuite::Async::Status do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'AsyncStatus' do
    context 'retrieving pending job status' do
      before do
        message = {
          "platformMsgs:jobId" => {:content! => "PENDING_JOB_ID"}
        }
        savon.expects(:check_async_status).with(:message => message).returns(File.read('spec/support/fixtures/async_get_status/async_get_status_pending.xml'))
      end

      it 'returns a valid AsyncStatus object' do
        status = NetSuite::Async::Status.get(job_id: 'PENDING_JOB_ID')
        expect(status).to be_kind_of(NetSuite::Async::Status)
      end

      it 'returns an AsyncStatus that has all the right fields' do
        status = NetSuite::Async::Status.get(job_id: 'PENDING_JOB_ID')
        [:job_id, :status, :percent_completed, :est_remaining_duration].each do |attribute|
          expect(status.respond_to?(attribute)).to be_truthy
        end
      end

      it 'returns an AsyncStatus where finished? is false' do
        status = NetSuite::Async::Status.get(job_id: 'PENDING_JOB_ID')
        expect(status.finished?).to be_falsey
      end

      it 'returns an AsyncStatus where errors? is false' do
        status = NetSuite::Async::Status.get(job_id: 'PENDING_JOB_ID')
        expect(status.errors?).to be_falsey
      end

      it 'returns an AsyncStatus where success? is false' do
        status = NetSuite::Async::Status.get(job_id: 'PENDING_JOB_ID')
        expect(status.success?).to be_falsey
      end
    end
  end

  context 'retrieving finished job status' do
    before do
      message = {
          "platformMsgs:jobId" => {:content! => "FINISHED_JOB_ID"}
      }
      savon.expects(:check_async_status).with(:message => message).returns(File.read('spec/support/fixtures/async_get_status/async_get_status_finished.xml'))
    end

    it 'returns an AsyncStatus where finished? is true' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_JOB_ID')
      expect(status.finished?).to be_truthy
    end

    it 'returns an AsyncStatus where errors? is false' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_JOB_ID')
      expect(status.errors?).to be_falsey
    end

    it 'returns an AsyncStatus where success? is true' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_JOB_ID')
      expect(status.success?).to be_truthy
    end
  end

  context 'retrieving finished with errors job status' do
    before do
      message = {
          "platformMsgs:jobId" => {:content! => "FINISHED_WITH_ERRORS_JOB_ID"}
      }
      savon.expects(:check_async_status).with(:message => message).returns(File.read('spec/support/fixtures/async_get_status/async_get_status_finished_with_errors.xml'))
    end

    it 'returns an AsyncStatus where finished? is true' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_WITH_ERRORS_JOB_ID')
      expect(status.finished?).to be_truthy
    end

    it 'returns an AsyncStatus where errors? is false' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_WITH_ERRORS_JOB_ID')
      expect(status.errors?).to be_truthy
    end

    it 'returns an AsyncStatus where success? is true' do
      status = NetSuite::Async::Status.get(job_id: 'FINISHED_WITH_ERRORS_JOB_ID')
      expect(status.success?).to be_falsey
    end
  end
end

