module NetSuite
  module Async
    class Status
      include Support::Fields

      read_only_fields :job_id, :status, :percent_completed, :est_remaining_duration

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      #<soap:Body>
      # <platformMsgs:checkAsyncStatus>
      #   <platformMsgs:jobId>ASYNCWEBSERVICES_563214_053120061943428686160042948_4bee0685
      #   </platformMsgs:jobId>
      # </platformMsgs:checkAsyncStatus>
      #</soap:Body>

      def self.get(options = {}, credentials = {})
        response = NetSuite::Configuration.connection(credentials).call(:check_async_status, :message => request_body(options))
        new(response.to_hash[:check_async_status_response][:async_status_result])
      end

      def self.request_body(options)
        {
          'platformMsgs:jobId' => { :content! => options[:job_id] }
        }
      end

      #<complexType name="AsyncStatusResult">
      # <sequence>
      #   <element name="jobId" type="xsd:string"/>
      #   <element name="status" type="platformCoreTyp:AsyncStatusType"/>
      #   <element name="percentCompleted" type="xsd:double"/>
      #   <element name="estRemainingDuration" type="xsd:double"/>
      #</sequence>
      #</complexType>

      #<simpleType name="AsyncStatusType">
      #  <restriction base="{http://www.w3.org/2001/XMLSchema}string">
      #    <enumeration value="failed"/>
      #    <enumeration value="finishedWithErrors"/>
      #    <enumeration value="pending"/>
      #    <enumeration value="processing"/>
      #    <enumeration value="finished"/>
      #  </restriction>
      #</simpleType>

      def finished?
        ['failed', 'finished', 'finishedWithErrors'].include?(status)
      end

      def success?
        status == "finished"
      end

      def errors?
        status == "finishedWithErrors"
      end

    end
  end
end