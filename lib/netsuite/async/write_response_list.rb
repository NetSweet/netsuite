# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/AsynchronousRequestProcessing.html
module NetSuite
  module Async
    class WriteResponseList

      attr_reader :list, :status, :type

      def initialize(async_result)
        @type = async_result[:"@xsi:type"]
        response_list = async_result[:write_response_list]
        @status = NetSuite::Status.new(response_list[:status]) if response_list[:status]
        responses =  Array[response_list[:write_response]].flatten
        @list = responses.map { |response| NetSuite::Async::WriteResponse.new(response) }
      end

      def self.get(options = {})
        response = NetSuite::Configuration.connection({element_form_default: :unqualified}).call(:get_async_result, message: request_body(options))
        self.new(response.to_hash[:get_async_result_response][:async_result])
      end

      def has_errors?
        return true if @status && !@status.success?
        @list.each do |result|
          return true unless result.success?
        end
        false
      end

      #<soap:Body>
      # <platformMsgs:getAsyncResult>
      #   <platformMsgs:jobId>ASYNCWEBSERVICES_563214_053120061943428686160042948_4bee0685</platformMsgs:jobId>
      #   <platformMsgs:pageIndex>1</platformMsgs:pageIndex>
      # </platformMsgs:getAsyncResult>
      #</soap:Body>
      def self.request_body(options)
        {
          'platformMsgs:jobId' => { :content! => options[:job_id] },
          'platformMsgs:pageIndex' => { :content! => options[:page_index] || 1 }
        }
      end

    end
  end
end
