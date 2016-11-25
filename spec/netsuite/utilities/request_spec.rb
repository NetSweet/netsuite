require 'spec_helper'

describe NetSuite::Rest::Utilities::Request do
  subject { described_class }

  describe '#get' do
    it { is_expected.to respond_to :get }
    let(:default_args) do
      { email: 'jim@godaddy.com', password: 'secret', uri: '/sandwich'}
    end

    [:email, :password, :uri].each do |key|
      it "throws an error if no #{key} key is given" do
        expect{
          subject.get(default_args.delete_if{|x| x == key})
        }.to raise_error(KeyError)
      end
    end

    it 'returns an array with the response code and parsed body' do
      allow(subject).to receive(:make_request).and_return(
        double(:response, code: "200", body: [{great: :body}].to_json)
      )
      expect( subject.get(default_args) ).to eq ["200", [{"great" => "body"}]]
    end
  end


end
