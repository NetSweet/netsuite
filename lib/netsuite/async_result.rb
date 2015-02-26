# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/AsynchronousRequestProcessing.html
module NetSuite
  class AsyncResult

    attr_reader :errors, :type

    def initialize(async_result)
      @type = async_result[:"@xsi:type"]

      base_ref_list = []
      errors = []

      if async_result[:read_response_list]
        response_list = async_result[:read_response_list][:read_response]
      else
        response_list = async_result[:write_response_list][:write_response]
      end

      Array[response_list].flatten.each do |response|
        if response[:status][:@is_success] == 'true'
          base_ref_list << response[:base_ref]
        elsif response[:status][:status_detail]
           response_errors = Array[response[:status][:status_detail]].flatten.map do |details|
             NetSuite::Error.new(details)
           end
           errors << [response[:base_ref][:@external_id], response_errors]
        end
      end

      @base_ref_list = NetSuite::Records::BaseRefList.new(base_ref: base_ref_list)
      @errors = Hash[errors]
    end

    def self.get(options = {})
      response = NetSuite::Configuration.connection({element_form_default: :unqualified}).call(:get_async_result, message: request_body(options))
      self.new(response.to_hash[:get_async_result_response][:async_result])
    end

    def record_refs
      @base_ref_list.base_ref
    end

    private

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
