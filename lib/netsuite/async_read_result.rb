# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/AsynchronousRequestProcessing.html
module NetSuite
  class AsyncReadResult < NetSuite::AsyncWriteResult

    protected

    def response_list(async_result)
      async_result[:read_response_list]
    end

    def responses(response_list)
      Array[response_list[:read_response]].flatten
    end

  end
end
