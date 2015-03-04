require 'spec_helper'

describe NetSuite::Async::WriteResponseList do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  let(:options) do
    { job_id: 'SOME_JOB_ID' }
  end

  let(:message) do
    {
      "platformMsgs:jobId" => { :content! => "SOME_JOB_ID" },
      "platformMsgs:pageIndex" => { :content! => 1 }
    }
  end

  context 'Invoices' do
    context 'results for AsyncAddList single invoice' do

      before do
        savon.expects(:get_async_result).with(:message => message).returns(File.read('spec/support/fixtures/async_write_results/single_invoice.xml'))
      end

      it 'returns a valid AsyncWriteResults object with the correct type' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results).to be_kind_of(NetSuite::Async::WriteResponseList)
        expect(results.type).to eql('AsyncAddListResult')
      end

      it 'returns an AsyncWriteResults object that has all the right attributes' do
        results = NetSuite::Async::WriteResponseList.get(options)
        [:status, :list].each do |attribute|
          expect(results.respond_to?(attribute)).to be_truthy
        end
      end

      it 'returns an AsyncWriteResults object with no overall status' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.status).to be_nil
      end

      it 'returns an AsyncWriteResults object where has_errors return false' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.has_errors?).to be_falsey
      end

      it 'returns an AsyncWriteResults object with a single successful result' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.list).to be_kind_of(Array)
        expect(results.list.length).to eql(1)
        result = results.list[0]
        expect(result).to be_kind_of(NetSuite::Async::WriteResponse)
        expect(result.success?).to be_truthy
        expect(result.base_ref.internal_id).to eql('internal id')
      end
    end

    context 'result for AsyncAddList single invalid invoice' do
      before do
        savon.expects(:get_async_result).with(:message => message).returns(File.read('spec/support/fixtures/async_write_results/single_invalid_invoice.xml'))
      end

      it 'returns an AsyncWriteResults object with no overall status' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.status).to be_nil
      end

      it 'returns an AsyncWriteResults object where has_errors return true' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.has_errors?).to be_truthy
      end

      it 'returns an AsyncWriteResults object with a single non-successful result' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.list.length).to eql(1)
        expect(results.list[0].success?).to be_falsey
        status = results.list[0].status
        expect(status).to be_kind_of(NetSuite::Status)
        expect(status.details).to be_kind_of(Array)
        expect(status.details.length).to eql(1)
        detail = status.details[0]
        expect(detail).to be_kind_of(NetSuite::StatusDetail)
        expect(detail.code).to eq('INVALID_KEY_OR_REF')
        expect(detail.message).to eq('Invalid item reference key 123 for entity 456.')
      end
    end

    context 'result for AsyncAddList two invoices, one invalid' do
      before do
        savon.expects(:get_async_result).with(:message => message).returns(File.read('spec/support/fixtures/async_write_results/two_invoices_one_invalid.xml'))
      end

      it 'returns an AsyncWriteResults object with no overall status' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.status).to be_nil
      end

      it 'returns an AsyncWriteResults object where has_errors return true' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.has_errors?).to be_truthy
      end

      it 'returns an AsyncWriteResults object with one successful and one non-successful result' do
        results = NetSuite::Async::WriteResponseList.get(options)
        expect(results.list.length).to eql(2)
        expect(results.list[0].success?).to be_truthy
        expect(results.list[1].success?).to be_falsey
        detail = results.list[1].status.details[0]
        expect(detail.code).to eq('INVALID_KEY_OR_REF')
        expect(detail.message).to eq('Invalid item reference key 123 for entity 456.')
      end
    end
  end
end
