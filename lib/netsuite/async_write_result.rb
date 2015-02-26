# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/AsynchronousRequestProcessing.html
module NetSuite
  class AsyncWriteResult

    attr_reader :response_error, :record_errors, :type

    def initialize(async_result)
      @type = async_result[:"@xsi:type"]

      response_list = response_list(async_result)

      if response_list[:status] && response_list[:status][:@is_success] == 'false' && response_list[:status][:status_detail]
        @response_error = NetSuite::Error.new(response_list[:status][:status_detail])
      end

      responses = responses(response_list)

      base_ref_list = responses.select { |r| r[:status][:@is_success] == 'true' }.map { |r| r[:base_ref] }
      @base_ref_list = NetSuite::Records::BaseRefList.new(base_ref: base_ref_list)

      @record_errors = {}
      responses.select { |r| r[:status][:@is_success] != 'true' && r[:status][:status_detail] }.each do |r|
        unless r[:base_ref]
          @response_error = NetSuite::Error.new(r[:status][:status_detail]) unless @response_error
          next
        end
        @record_errors[r[:base_ref][:@external_id]] = r[:status][:status_detail]
      end
    end

    def self.get(options = {})
      response = NetSuite::Configuration.connection({element_form_default: :unqualified}).call(:get_async_result, message: request_body(options))
      self.new(response.to_hash[:get_async_result_response][:async_result])
    end

    def record_refs
      @base_ref_list.base_ref
    end

    protected

    def response_list(async_result)
      async_result[:write_response_list]
    end

    def responses(response_list)
      Array[response_list[:write_response]].flatten
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
        'platformMsgs:pageIndex' => { :content! => options[:page_index] }
      }
    end

  end
end
