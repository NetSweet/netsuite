# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/login.html

module NetSuite
  module Actions
    class Login

      # <userId xmlns:platformCore="urn:core_2013_1.platform.webservices.netsuite.com" internalId="460362">
      #   <platformCore:name>REDACTED ORG NAME</platformCore:name>
      # </userId>
      # <platformCore:wsRoleList xmlns:platformCore="urn:core_2013_1.platform.webservices.netsuite.com">
      #   <platformCore:wsRole>
      #     <platformCore:role internalId="1047">
      #       <platformCore:name>REDACTED ROLE</platformCore:name>
      #     </platformCore:role>
      #     <platformCore:isDefault>false</platformCore:isDefault>
      #     <platformCore:isInactive>false</platformCore:isInactive>
      #     <platformCore:isLoggedInRole>true</platformCore:isLoggedInRole>
      #   </platformCore:wsRole>
      #   <platformCore:wsRole>
      #     <platformCore:role internalId="1047">
      #       <platformCore:name>REDACTED ROLE</platformCore:name>
      #     </platformCore:role>
      #     <platformCore:isDefault>false</platformCore:isDefault>
      #     <platformCore:isInactive>false</platformCore:isInactive>
      #     <platformCore:isLoggedInRole>true</platformCore:isLoggedInRole>
      #   </platformCore:wsRole>
      # </platformCore:wsRoleList>

      def self.call(credentials)
        passport = NetSuite::Configuration.auth_header.dup
        passport['platformMsgs:passport']['platformCore:email'] = credentials[:email] || ''
        passport['platformMsgs:passport']['platformCore:password'] = credentials[:password] || ''
        passport['platformMsgs:passport']['platformCore:role'] = credentials[:role] || ''
        passport['platformMsgs:passport']['platformCore:account'] = credentials[:account] || ''

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

        # include more data in body; leave it up to the user to pull the data they are looking for
        NetSuite::Response.new(
          success: response.to_hash[:login_response][:session_response][:status][:@is_success] == 'true',
          body: response.to_hash[:login_response][:session_response]
        )
      end

    end
  end
end
