require 'spec_helper'

describe NetSuite::Utilities do
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
