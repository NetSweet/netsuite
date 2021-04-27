require 'spec_helper'

describe 'basic records' do
  # all records with internal IDs should be added to this list
  let(:basic_record_list) {
    [
      NetSuite::Records::Currency,
      NetSuite::Records::CashSale,
      NetSuite::Records::CashRefund,
      NetSuite::Records::Location,
      NetSuite::Records::JobStatus,
      NetSuite::Records::TimeBill,
      NetSuite::Records::Customer,
      NetSuite::Records::Invoice,
      NetSuite::Records::PayrollItem,
      NetSuite::Records::Opportunity,
      NetSuite::Records::VendorCategory,
      NetSuite::Records::VendorCredit,
      NetSuite::Records::VendorBill,
      NetSuite::Records::Deposit,
      NetSuite::Records::RevRecTemplate,
      NetSuite::Records::RevRecSchedule,
      NetSuite::Records::JournalEntry,
      NetSuite::Records::Classification,
      NetSuite::Records::SalesOrder,
      NetSuite::Records::CustomerDeposit,
      NetSuite::Records::NonInventoryPurchaseItem,
      NetSuite::Records::NonInventoryResaleItem,
      NetSuite::Records::LotNumberedInventoryItem,
      NetSuite::Records::TaxGroup,
      NetSuite::Records::Folder,
      NetSuite::Records::CustomerCategory,
      NetSuite::Records::File,
      NetSuite::Records::TransferOrder,
      NetSuite::Records::Partner,
      NetSuite::Records::PurchaseOrder,
      NetSuite::Records::ItemReceipt,
      NetSuite::Records::GiftCertificate,
      NetSuite::Records::ContactRole,
      NetSuite::Records::PaymentItem,
      NetSuite::Records::CreditMemo,
      NetSuite::Records::InventoryItem,
      NetSuite::Records::DescriptionItem,
      NetSuite::Records::SubtotalItem,
      NetSuite::Records::Term,
      NetSuite::Records::Note,
      NetSuite::Records::OtherChargeSaleItem,
      NetSuite::Records::GiftCertificateItem,
      NetSuite::Records::ReturnAuthorization,
      NetSuite::Records::SerializedInventoryItem,
      NetSuite::Records::DepositApplication,
      NetSuite::Records::InventoryAdjustment,
      NetSuite::Records::Vendor,
      NetSuite::Records::VendorReturnAuthorization,
      NetSuite::Records::AssemblyBuild,
      NetSuite::Records::AssemblyUnbuild,
      NetSuite::Records::AssemblyComponent,
      NetSuite::Records::InventoryNumber,
      NetSuite::Records::PriceLevel,
      NetSuite::Records::LotNumberedAssemblyItem,
      NetSuite::Records::InboundShipment,
      NetSuite::Records::InterCompanyJournalEntry,
      NetSuite::Records::BinTransfer,
      NetSuite::Records::SerializedAssemblyItem,
      NetSuite::Records::CustomerStatus,
      NetSuite::Records::CustomerPayment,
      NetSuite::Records::TransactionBodyCustomField,
      NetSuite::Records::TransactionColumnCustomField,
      NetSuite::Records::EntityCustomField
    ]
  }

  it 'can be initialized, has fields, and can be converted into a record' do
    basic_record_list.each do |record_class|
      record_instance = record_class.new

      # most records have a
      expect(record_class.fields.size).to be > 0
      expect(record_class.record_refs).to_not be_nil
      expect(record_instance).to respond_to(:internal_id)

      # NOTE all records have externalIds, not testing exernalId setter
      if record_class.respond_to?(:upsert)
        expect(record_instance).to respond_to(:external_id)
        expect(record_instance).to respond_to(:external_id=)
      end

      standard_fields = (record_class.fields - record_class.record_refs).to_a
      custom_object_fields = standard_fields.select { |f| !record_instance.send(f).nil? }
      sublist_fields = custom_object_fields.select { |f| record_instance.send(f).kind_of?(NetSuite::Support::Sublist) }

      custom_object_fields -= sublist_fields
      standard_fields -= custom_object_fields
      standard_fields -= sublist_fields

      # ensure that all fields can be set
      standard_fields.each { |f| expect(record_instance).to have_field(f) }
      record_class.record_refs.each { |f| expect(record_instance).to have_record_ref(f) }

      # TODO handle custom object fields

      6.times do
        record_instance.send(:"#{standard_fields.sample}=", "Test Value")
      end

      if !record_class.record_refs.empty?
        sample_record_ref_field = record_class.record_refs.to_a.sample

        record_instance.send(:"#{sample_record_ref_field}=".to_sym, { internal_id: 1 })
      end

      if !sublist_fields.empty?
        sublist_fields.each do |sublist_field|
          sublist = record_instance.send(sublist_field)

          # TODO make a sublist entry with some fields valid for that sublist item
          sublist << {}

          expect(sublist.send(sublist.sublist_key).count).to be(1)
        end
      end

      expect(record_instance.to_record).to be_a(Hash)

      # TODO should test for correct value output
    end
  end
end
