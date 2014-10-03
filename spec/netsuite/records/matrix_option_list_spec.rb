require 'spec_helper'
require 'ostruct'

module NetSuite
  module Records
    describe MatrixOptionList do
      it "deals with hash properly" do
        hash = {:value=>{:@internal_id=>"1", :@type_id=>"36"}}

        list = described_class.new({ matrix_option: hash })
        expect(list.options.first.value_id).to eq "1"
      end

      it "deals with arrays properly" do
        array = [
          {:value=>{:@internal_id=>"2", :@type_id=>"28"}},
          {:value=>{:@internal_id=>"1", :@type_id=>"29"}}
        ]

        list = described_class.new({ matrix_option: array })
        expect(list.options.first.value_id).to eq "2"
      end
    end
  end
end
