require 'spec_helper'

describe NetSuite::Support::SearchResult do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  describe '#results' do
    context 'empty page' do
      it 'returns empty array' do
        response_body = {
          :status => {:@is_success=>"true"},
          :total_records => "242258",
          :page_size => "10",
          :total_pages => "24226",
          :page_index => "99",
          :search_id => "WEBSERVICES_4132604_SB1_051620191060155623420663266_336cbf12",
          :record_list => nil,
          :"@xmlns:platform_core" => "urn:core_2016_2.platform.webservices.netsuite.com"
        }
        response = NetSuite::Response.new(body: response_body)

        results = described_class.new(response, NetSuite::Actions::Search, {}).results
        expect(results).to eq []
      end
    end

    it 'handles a recordList with a single element' do
      response = File.read('spec/support/fixtures/search/single_search_result.xml')
      savon.expects(:search).with(message: {}).returns(response)

      results = NetSuite::Records::Account.search(basic: [])

      expect(results.results.count).to eq 1
    end
  end
end
