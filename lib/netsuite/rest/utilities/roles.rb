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
            uniq_accounts = parsed.map {|hash| hash["account"] }.uniq

            uniq_accounts.map do |hash|
              matches = parsed.select {|x| x["account"]["internalId"] == hash["internalId"]}
              {
                account_id:    hash["internalId"],
                account_name:  hash["name"],
                roles: matches.map do |match|
                  {
                    id:   match["role"]["internalId"],
                    name: match["role"]["name"]
                  }
                end.uniq,
                wsdls: {
                  webservices: matches.map {|match| match["dataCenterURLs"]["webservicesDomain"] }.uniq,
                  rest:        matches.map {|match| match["dataCenterURLs"]["restDomain"] }.uniq,
                  system:      matches.map {|match| match["dataCenterURLs"]["systemDomain"] }.uniq,
                }
              }
            end
          end

        end
      end
    end
  end
end
