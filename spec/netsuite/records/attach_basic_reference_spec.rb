require 'spec_helper'

describe NetSuite::Records::AttachBasicReference do
  let(:attach_basic_reference) { NetSuite::Records::AttachBasicReference.new }

  it "has all the right record refs" do
    [:attach_to, :attached_record].each do |record_ref|
      expect(attach_basic_reference).to have_record_ref(record_ref)
    end
  end

  describe '#attach' do
    let(:test_data) { {:attach_to => {internal_id: "11111", type: "VendorBill"}, :attached_record => {internal_id: "22222", type: "File"} } }
    context 'when the response is successful' do 
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '11111' }) }

      it "returns true" do
        attach_basic_reference = NetSuite::Records::AttachBasicReference.new(test_data)

        expect(NetSuite::Actions::Attach).to receive(:call).with([attach_basic_reference], {}).and_return(response)
        expect(attach_basic_reference.attach).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        attach_basic_reference = NetSuite::Records::AttachBasicReference.new(test_data)

        expect(NetSuite::Actions::Attach).to receive(:call).with([attach_basic_reference], {}).and_return(response)
        expect(attach_basic_reference.attach).to be_falsey
      end
    end

  end

end
