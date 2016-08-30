module NetSuite
  module Rest
    module Utilities
      class Roles

        class << self

          def get(opts={})
            status, body = Request.get(
              email:    opts.fetch(:email, Configuration.email),
              password: opts.fetch(:password, Configuration.password),
              sandbox:  opts.fetch(:sandbox, Configuration.sandbox),
              uri:      '/roles',
            )
            status == "200" ? format_response(body) : body
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
