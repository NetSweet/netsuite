# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/login.html
module NetSuite
  module Actions
    class Login

      def self.call(credentials)
        passport = NetSuite::Configuration.auth_header.dup
        passport['platformMsgs:passport']['platformCore:email'] = credentials[:email] || ''
        passport['platformMsgs:passport']['platformCore:password'] = credentials[:password] || ''
        passport['platformMsgs:passport']['platformCore:role'] = credentials[:role] || ''

        begin
          response = NetSuite::Configuration.connection(soap_header: {}).call :login, message: passport
        rescue Savon::SOAPFault => e
          error_details = e.to_hash[:fault]

          return NetSuite::Response.new(
            success: false,
            errors: [ NetSuite::Error.new(
              code: error_details[:detail][:invalid_credentials_fault][:code],
              message: error_details[:faultstring]
            )],
            body: error_details
          )
        end

        NetSuite::Response.new(
          success: response.to_hash[:login_response][:session_response][:status][:@is_success] == 'true',
          body: response.to_hash[:login_response][:session_response][:base_ref]
        )
      end

    end
  end
end
