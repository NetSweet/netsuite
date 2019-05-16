require 'spec_helper'

describe NetSuite::Support::SearchResult do
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
  end
end
