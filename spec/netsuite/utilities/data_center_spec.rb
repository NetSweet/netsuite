require 'spec_helper'

describe NetSuite::Utilities::DataCenter do
  describe '#get' do
    let(:wsdl) { "https://webservices.na1.netsuite.com" }
    let(:account) { "BOGUSACCT" }
    let(:response) do
      double(
        success?: true,
        body: {
          get_data_center_urls_response: {
            get_data_center_urls_result: {
              data_center_urls: { webservices_domain: wsdl }
            }
          }
        }
      )
    end

    context 'without caching' do
      it 'hits the API more than once' do
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)
        10.times { described_class.get(account) }

        expect(described_class).to have_received(:make_data_center_call)
          .with(account).exactly(10).times
      end

    end

    context 'when caching is enabled' do

      it 'doesnt hit the API when cached response is present' do
        described_class.class_exec(account) {|acct| cache[acct] = "wsdl" }
        allow(described_class).to receive(:make_data_center_call)
        described_class.get(account, cache: true)

        expect(described_class).to_not have_received(:make_data_center_call)
      end

      it 'hits the API at most once' do
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)
        10.times { described_class.get(account, cache: true) }

        expect(described_class).to have_received(:make_data_center_call)
          .with(account).exactly(1).times
      end

      it 'hits the API after its cache is cleared' do
        described_class.class_exec(account) {|acct| cache[acct] = "wsdl" }
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)
        described_class.get(account, cache: true)

        expect(described_class).to_not have_received(:make_data_center_call)

        described_class.clear_cache!
        described_class.get(account, cache: true)

        expect(described_class).to have_received(:make_data_center_call)
          .with(account).exactly(1).times
      end

      it 'hits the API if the cache contains another response' do
        described_class.class_eval { cache["BOGUS"] = "wsdl" }
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)
        expect(account).to_not eq("BOGUS")
        described_class.get(account, cache: true)

        expect(described_class).to have_received(:make_data_center_call)
          .with(account).exactly(1).times
      end
    end

    context 'when cache is empty' do

      it 'does hit the API' do
        expect( described_class.class_eval { cache }).to eq({})
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)

        described_class.get(account, cache: true)

        expect(described_class).to have_received(:make_data_center_call)
          .with(account).exactly(1).times
      end

      it 'stores API response' do
        expect( described_class.class_eval { cache }).to eq({})
        allow(described_class).to receive(:make_data_center_call)
          .with(account)
          .and_return(response)

        described_class.get(account, cache: true)

        expect( described_class.class_eval { cache }).to eq(
          { account => wsdl }
        )
      end
    end
  end
end
