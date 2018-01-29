require 'spec_helper'

module NetSuite
  module Records
    describe ItemFulfillment do
      context "unify package list attributes" do
        let(:package_ups_list) do
          {
            :package_weight_ups=>"4.0",
            :package_tracking_number_ups=>"1ZYA95390396947456",
            :packaging_ups=>"_yourPackaging",
            :use_insured_value_ups=>false,
            :reference1_ups=>"spree@example.com",
            :reference2_ups=>"spree@example.com",
            :package_length_ups=>"24",
            :package_width_ups=>"24",
            :package_height_ups=>"24",
            :additional_handling_ups=>false,
            :use_cod_ups=>false
          }
        end

        let(:list) do
          { package_ups_list: { package_ups: package_ups_list } }
        end

        subject do
          described_class.new(list)
        end

        it "access ups attributes via package_list" do
          package = subject.package_list.packages.first
          expect(package.package_tracking_number).to eq package_ups_list[:package_tracking_number_ups]
        end

        context "array" do
          let(:list) do
            { package_ups_list: { package_ups: [package_ups_list, package_ups_list] } }
          end

          it "access ups attributes via package_list" do
            package = subject.package_list.packages.first
            expect(package.package_tracking_number).to eq package_ups_list[:package_tracking_number_ups]
          end
        end
      end

      it 'has all the right record refs' do
        [
          :custom_form, :entity, :created_from, :ship_carrier, :ship_method,
          :ship_address_list, :klass, :ship_country, :posting_period
        ].each do |record_ref|
          expect(subject).to have_record_ref(record_ref)
        end
      end
    end
  end
end
