require 'spec_helper'

describe NetSuite::Actions::Attach do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context "AttachBasicReference" do
    let(:attach_basic_reference) do
      NetSuite::Records::AttachBasicReference.new(:attach_to => {internal_id: "11111", type: "VendorBill"}, :attached_record => {internal_id: "22222", type: "File"})
    end

    before do 
      savon.expects(:attach).with(:message => {
        'platformMsgs:attachReferece' => {
          :content! => {
            :attributes! => {
              "platformCore:attachTo" => {
                "internalId"=>"11111", 
                "type"=>"vendorBill",  "xsi:type"=>"platformCore:RecordRef"
              },
              "platformCore:attachedRecord"=> {
                "internalId"=>"22222", 
                "type"=>"file", 
                "xsi:type"=>"platformCore:RecordRef"
              }
            },
            "platformCore:attachTo"=>{},
            "platformCore:attachedRecord"=>{}
          },
          "@xsi:type"=>"platformCore:AttachBasicReference"
          }
        }).returns(File.read('spec/support/fixtures/attach/attach_file_to_bill.xml'))  
    end


    it "makes a valid request to the NetSuite API" do 
      NetSuite::Actions::Attach.call([attach_basic_reference])
    end

    it "returns a valid Response object" do 
      response = NetSuite::Actions::Attach.call([attach_basic_reference])
      expect(response).to be_kind_of(NetSuite::Response)
      expect(response).to be_success
    end

    context "when not successful" do
      before do 
        savon.expects(:attach).with(:message => {
          'platformMsgs:attachReferece' => {
            :content! => {
              :attributes! => {
                "platformCore:attachTo" => {
                  "internalId"=>"11111", 
                  "type"=>"vendorBill",  "xsi:type"=>"platformCore:RecordRef"
                },
                "platformCore:attachedRecord"=> {
                  "internalId"=>"22222", 
                  "type"=>"file", 
                  "xsi:type"=>"platformCore:RecordRef"
                }
              },
              "platformCore:attachTo"=>{},
              "platformCore:attachedRecord"=>{}
            },
            "@xsi:type"=>"platformCore:AttachBasicReference"
            }
          }).returns(File.read('spec/support/fixtures/attach/attach_file_to_bill_error.xml'))  
      end

      it 'provides an error method on the object with details about the error' do 
        #i'm not sure why the only way to get the errors is to attach twice 
        attach_basic_reference.attach
        attach_basic_reference.attach
        error = attach_basic_reference.errors.first
        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('USER_ERROR')
        expect(error.message).to eq('Invalid Attachment record combination')
      end
    end
  end
end
