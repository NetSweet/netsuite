require 'spec_helper'

describe NetSuite::Actions::Login do
  before { savon.mock! }
  after { savon.unmock! }

  it 'properly executes a login call' do
    message = {"platformMsgs:passport"=>{"platformCore:email"=>"email", "platformCore:password"=>"password", "platformCore:account"=>"1234", "platformCore:role"=>234}}

    savon.expects(:login).with(:message => message).returns(File.read('spec/support/fixtures/login.xml'))

    result = NetSuite::Actions::Login.call({
      email: 'email',
      password: 'password',
      role: 234
    })

    expect(result.success?).to eq(true)
    expect(result.body[:user_id]).to_not be_nil
  end
end
