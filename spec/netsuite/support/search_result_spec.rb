require 'spec_helper'

describe NetSuite::Support::SearchResult do
  describe '#initialize' do
    context 'when it is basic column search' do
      let(:response) do
        NetSuite::Response.new(
          :success=>true,
          :header=> {
            :ns_id=>"WEBSER",
            :"@xmlns:platform_msgs"=>"urn:messages_2016_1.platform.webservices.netsuite.com"
          },
          :body => {
            :status => {:@is_success=>"true"},
            :total_records=>"1",
            :page_size=>"100",
            :total_pages=>"1",
            :page_index=>"1",
            :search_id=>"WEBSER",
            :search_row_list=>{
              :search_row=>[
                {:basic=>{
                  :amount_paid=>{:search_value=>"0.0"},
                  :amount_remaining=>{:search_value=>"6030.0"},
                  :date_created=>{:search_value=> Time.new(2013)},
                  :entity=>{:search_value=>{:@internal_id=>"11"}},
                  :internal_id=>{:search_value=>{:@internal_id=>"5"}},
                  :total=>{:search_value=>"6030.0"},
                  :tran_date=>{:search_value=> Time.new(2013)},
                  :tran_id=>{:search_value=>"2"},
                  :transaction_number=>{:search_value=>"2"},
                  :"@xmlns:platform_common"=>"urn:common_2016_1.platform.webservices.netsuite.com"},
                  :"@xmlns:tran_sales"=>"urn:sales_2016_1.transactions.webservices.netsuite.com",
                  :"@xsi:type"=>"tranSales:TransactionSearchRow"
                }
              ]
            }
          }
        )
      end

      let(:result) do
        NetSuite::Support::SearchResult.new(
          response,
          NetSuite::Records::Invoice
        ).results.first
      end

      it 'passes the internal_id into record_ref correctly' do
        expect(result.entity.internal_id.to_i).to eq(11)
      end
    end
  end
end
