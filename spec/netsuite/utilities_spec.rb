require 'spec_helper'

describe NetSuite::Utilities do
  describe 'time utilities' do
    it '#normalize_time_to_netsuite_date' do
      ['Etc/UTC', 'America/Los_Angeles', 'America/Denver'].each do |zone|
        ENV['TZ'] = zone
        puts "In zone: #{zone}"

        stamp = DateTime.parse('Wed, 27 Jul 2016 00:00:00 -0000')
        formatted_date = NetSuite::Utilities.normalize_time_to_netsuite_date(stamp.to_time.to_i)
        expect(formatted_date).to eq('2016-07-27T00:00:00-07:00')

        no_dst_stamp = DateTime.parse('Sun, November 6 2017 00:00:00 -0000')
        formatted_date = NetSuite::Utilities.normalize_time_to_netsuite_date(no_dst_stamp.to_time.to_i)
        if Gem.loaded_specs.has_key?('tzinfo')
          expect(formatted_date).to eq('2017-11-06T00:00:00-08:00')
        else
          expect(formatted_date).to eq('2017-11-06T00:00:00-07:00')
        end

        no_dst_stamp_with_time = DateTime.parse('Sun, November 6 2017 12:11:10 -0000')
        formatted_date = NetSuite::Utilities.normalize_time_to_netsuite_date(no_dst_stamp_with_time.to_time.to_i)
        if Gem.loaded_specs.has_key?('tzinfo')
          expect(formatted_date).to eq('2017-11-06T00:00:00-08:00')
        else
          expect(formatted_date).to eq('2017-11-06T00:00:00-07:00')
        end
      end
    end
  end

  it "#netsuite_data_center_urls" do
    domains = NetSuite::Utilities.netsuite_data_center_urls('TSTDRV1576318')
    expect(domains[:webservices_domain]).to eq('https://tstdrv1576318.suitetalk.api.netsuite.com')
    expect(domains[:system_domain]).to eq('https://tstdrv1576318.app.netsuite.com')

    # ensure domains returned don't change when sandbox is enabled
    NetSuite.configure do
      reset!
      sandbox true
    end

    domains = NetSuite::Utilities.netsuite_data_center_urls('TSTDRV1576318')
    expect(domains[:webservices_domain]).to eq('https://tstdrv1576318.suitetalk.api.netsuite.com')
    expect(domains[:system_domain]).to eq('https://tstdrv1576318.app.netsuite.com')

    NetSuite.configure do
      reset!
      api_version '2015_1'
    end

    domains = NetSuite::Utilities.netsuite_data_center_urls('TSTDRV1576318')
    expect(domains[:webservices_domain]).to eq('https://tstdrv1576318.suitetalk.api.netsuite.com')
    expect(domains[:system_domain]).to eq('https://tstdrv1576318.app.netsuite.com')

    domains = NetSuite::Utilities.netsuite_data_center_urls('4810331')
    expect(domains[:webservices_domain]).to eq('https://4810331.suitetalk.api.netsuite.com')
    expect(domains[:system_domain]).to eq('https://4810331.app.netsuite.com')
  end

  describe '#get_record' do
    context 'caching' do
      it 'does not hit the netsuite API' do
        ns_account_id = 123
        allow(NetSuite::Records::Account).to receive(:get).with(ns_account_id).once.and_return(
          NetSuite::Records::Account.new(internal_id: ns_account_id)
        )

        ns_account = NetSuite::Utilities.get_record(NetSuite::Records::Account, ns_account_id, cache: true)
        expect(ns_account.internal_id).to eq(ns_account_id)

        ns_account = NetSuite::Utilities.get_record(NetSuite::Records::Account, ns_account_id, cache: true)
        expect(ns_account.internal_id).to eq(ns_account_id)
      end

      it 'works on missing records' do
        ns_account_id = 123
        allow(NetSuite::Records::Account).to receive(:get).with(ns_account_id) do
          raise NetSuite::RecordNotFound
        end

        20.times do
          expect(
            NetSuite::Utilities.get_record(
              NetSuite::Records::Account, ns_account_id, cache: true
            )
          ).to eq nil
        end

        expect(NetSuite::Records::Account).to have_received(:get).exactly(1).times
      end

      it 'works when an unexpected error occurs' do
        xml_msg = <<EOL
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <soapenv:Header>
    <platformMsgs:documentInfo xmlns:platformMsgs="urn:messages_2015_1.platform.webservices.netsuite.com">
      <platformMsgs:nsId>WEBSERVICES_TSTDRV1022750_103020151182829907744988579_5d1f6b</platformMsgs:nsId>
    </platformMsgs:documentInfo>
  </soapenv:Header>
  <soapenv:Body>
    <updateResponse xmlns="urn:messages_2015_1.platform.webservices.netsuite.com">
      <writeResponse>
        <platformCore:status xmlns:platformCore="urn:core_2015_1.platform.webservices.netsuite.com" isSuccess="false">
          <platformCore:statusDetail type="ERROR">
            <platformCore:code>UNEXPECTED_ERROR</platformCore:code>
            <platformCore:message>An unexpected error occurred. Error ID: igduqcc81p7jpm8fklupr</platformCore:message>
          </platformCore:statusDetail>
        </platformCore:status>
        <baseRef xmlns:platformCore="urn:core_2015_1.platform.webservices.netsuite.com" internalId="50534" type="revRecSchedule" xsi:type="platformCore:RecordRef"/>
      </writeResponse>
    </updateResponse>
  </soapenv:Body>
</soapenv:Envelope>
EOL
        xml_msg = <<EOL
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<soapenv:Body>
  <soapenv:Fault>
    <faultcode>soapenv:Server.userException</faultcode>
    <faultstring>An unexpected error occurred</faultstring>
    <detail>
      <ns1:hostname xmlns:ns1="http://xml.apache.org/axis/">partners-java10006.bos.netledger.com</ns1:hostname>
    </detail>
  </soapenv:Fault>
</soapenv:Body>
EOL

        # <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        #   <soapenv:Body>
        #     <soapenv:Fault>
        #       <faultcode>soapenv:Server.userException</faultcode>
        #       <faultstring>You do not have permission to access web services feature.</faultstring>
        #       <detail>
        #         <platformFaults:UnexpectedErrorFault xmlns:platformFaults="urn:faults_2015_1.platform.webservices.netsuite.com">
        #           <platformFaults:code>UNEXPECTED_ERROR</platformFaults:code>
        #           <platformFaults:message>An unexpected error occurred. Error ID: j0b0mmf81qhk9h7ezjgbz</platformFaults:message>
        #         </platformFaults:UnexpectedErrorFault>
        #         <ns1:hostname xmlns:ns1="http://xml.apache.org/axis/">partners-java10001.bos.netledger.com</ns1:hostname>
        #       </detail>
        #     </soapenv:Fault>
        #   </soapenv:Body>
        # </soapenv:Envelope>

        ns_account_id = 123

        exception = Savon::SOAPFault.new(OpenStruct.new(body: xml_msg), Nori.new({}), xml_msg)

        allow(NetSuite::Records::Account).to receive(:get).and_raise(exception)

        NetSuite::Utilities.get_record(NetSuite::Records::Account, ns_account_id)
      end
    end

    it 'pulls a record by internal id' do
      ns_account_id = 123
      ns_account_external_id = "abc"
      allow(NetSuite::Records::Account).to receive(:get).with({ external_id: ns_account_external_id }).once.and_return(
        NetSuite::Records::Account.new(internal_id: ns_account_id)
      )

      ns_account = NetSuite::Utilities.get_record(NetSuite::Records::Account, ns_account_external_id, external_id: true)
      expect(ns_account.internal_id).to eq(ns_account_id)
    end

    it 'pulls a record by external id' do
      ns_account_id = 123
      allow(NetSuite::Records::Account).to receive(:get).with(ns_account_id).once.and_return(
        NetSuite::Records::Account.new(internal_id: ns_account_id)
      )

      ns_account = NetSuite::Utilities.get_record(NetSuite::Records::Account, ns_account_id)
      expect(ns_account.internal_id).to eq(ns_account_id)
    end
  end
end
