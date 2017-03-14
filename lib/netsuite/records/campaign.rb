module NetSuite
  module Records
    class Campaign
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions

      actions :get, :get_list, :search

      fields :audience, :base_cost, :campaign_direct_mail_list, :campaign_email_list,
        :campaign_event_list, :campaign_id, :category, :conv_cost_per_customer, :conversions,
        :cost, :cost_per_customer, :end_date, :event_response_list, :expected_revenue,
        :family, :is_inactive, :item_list, :keyword, :leads_generated, :message,
        :offer, :owner, :profit, :promotion_code, :roi, :search_engine, :start_date, :title,
        :total_revenue, :unique_visitors, :url, :vertical

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
