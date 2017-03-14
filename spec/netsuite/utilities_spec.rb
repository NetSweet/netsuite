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
