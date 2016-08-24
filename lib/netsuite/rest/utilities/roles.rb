module NetSuite
  module Rest
    module Utilities
      class Roles

        class << self

          def get(email, password)
            code, body = Request.get(
              email: email,
              password: password,
              uri: '/roles'
            )
            code == "200" ? format_response(body) : body
          end

          private

          def format_response(parsed)
            # [
            #   {
            #    "account"=>{
            #      "internalId"=>"TSTDRV15",
            #      "name"=>"Honeycomb Mfg SDN (Leading)"},
            #    "role"=>{
            #      "internalId"=>3,
            #      "name"=>"Administrator"},
            #    "dataCenterURLs"=>{
            #      "webservicesDomain"=>"https://webservices.na1.netsuite.com",
            #      "restDomain"=>"https://rest.na1.netsuite.com",
            #      "systemDomain"=>"https://system.na1.netsuite.com"}
            #    },
            #   ....
            {
              accounts: parsed.map {|hash| hash["account"]["internalId"] }.uniq,
              roles:    parsed.map {|hash| hash["role"]["internalId"] }.uniq,
              wsdls:    parsed.map {|hash| hash["dataCenterURLs"]["webservicesDomain"] }.uniq,
            }
          end

        end
      end
    end
  end
end
