require 'spec_helper'

describe NetSuite::Actions::Login do
  before { savon.mock! }
  after { savon.unmock! }

  it 'handles a successful login call' do
    message = {"platformMsgs:passport"=>{"platformCore:email"=>"email", "platformCore:password"=>"password", "platformCore:account"=>"1234", "platformCore:role"=>234}}
    savon.expects(:login).with(:message => message).returns(File.read('spec/support/fixtures/login/success.xml'))

    result = NetSuite::Actions::Login.call({
      email: 'email',
      password: 'password',
      role: 234
    })

    expect(result.success?).to eq(true)
    expect(result.body[:user_id]).to_not be_nil
  end

  it 'handles a failed login call because of a concurrent request error' do
    message = {"platformMsgs:passport"=>{"platformCore:email"=>"email", "platformCore:password"=>"password", "platformCore:account"=>"1234", "platformCore:role"=>234}}
    savon.expects(:login).with(:message => message).returns(File.read('spec/support/fixtures/login/failure_invalid_credentials.xml'))

    result = NetSuite::Actions::Login.call({
      email: 'email',
      password: 'password',
      role: 234
    })

    expect(result.success?).to eq(false)
  end

  it 'handles a failed login call because of a concurrent request error' do
    message = {"platformMsgs:passport"=>{"platformCore:email"=>"email", "platformCore:password"=>"password", "platformCore:account"=>"1234", "platformCore:role"=>234}}
    savon.expects(:login).with(:message => message).returns(File.read('spec/support/fixtures/login/failure_concurrent_requests.xml'))

    expect { NetSuite::Actions::Login.call({
      email: 'email',
      password: 'password',
      role: 234
    }) }.to raise_error(Savon::SOAPFault)
  end
end
