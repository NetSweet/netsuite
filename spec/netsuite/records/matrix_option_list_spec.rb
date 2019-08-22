require 'spec_helper'
require 'ostruct'

module NetSuite
  module Records
    describe MatrixOptionList do
      it "deals with hash properly" do
        hash = {:value=>{:@internal_id=>"1", :@type_id=>"36", :name=>"some value"}, :@script_id=>'cust_field_1'}

        list = described_class.new({ matrix_option: hash })
        option = list.options.first
        expect(option.value_id).to eq "1"
        expect(option.type_id).to eq "36"
        expect(option.name).to eq "some value"
        expect(option.script_id).to eq "cust_field_1"
      end

      it "deals with arrays properly" do
        array = [
          {:value=>{:@internal_id=>"2", :@type_id=>"28", :name=>"some value 28"}, :@script_id=>'cust_field_28'},
          {:value=>{:@internal_id=>"1", :@type_id=>"29", :name=>"some value 29"}, :@script_id=>'cust_field_29'}
        ]

        list = described_class.new({ matrix_option: array })
        expect(list.options.count).to eq 2

        option = list.options.first
        expect(option.value_id).to eq "2"
        expect(option.type_id).to eq "28"
        expect(option.name).to eq "some value 28"
        expect(option.script_id).to eq "cust_field_28"
      end
    end
  end
end
