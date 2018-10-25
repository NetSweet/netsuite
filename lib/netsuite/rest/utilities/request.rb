require 'net/http'
require 'uri'
require 'json'

module NetSuite
  module Rest
    module Utilities
      class Request

        PRODUCTION_API = "https://rest.netsuite.com/rest"
        SANDBOX_API = "https://rest.sandbox.netsuite.com/rest"
        DEFAULT_TIMEOUT = 30
        USE_SSL = true

        class << self

          def get(options)
            email       = encode(options.fetch :email)
            signature   = encode(options.fetch :password)
            sandbox     = options.fetch(:sandbox, false)
            uri         = determine_uri(options.fetch(:uri), sandbox)
            response    = make_request(:get, uri, email, signature)
            [response.code, JSON.parse(response.body)]
          end

          private

          def make_request(method_name, uri, email, signature)
            klass = Module.const_get "Net::HTTP::#{method_name.to_s.capitalize}"
            method = klass.new(uri)
            method['AUTHORIZATION'] = auth_header(email, signature)

            http = Net::HTTP.new(uri.hostname, uri.port)
            http.use_ssl      = USE_SSL
            http.ssl_version = :TLSv1_2
            http.read_timeout = DEFAULT_TIMEOUT

            # TODO username + password will be outputted to STDOUT if this is enabled
            # if !NetSuite::Configuration.silent
            #   http.set_debug_output(NetSuite::Configuration.logger)
            # end

            http.start { |http| http.request(method) }
          end

          def auth_header(email, signature)
            "NLAuth nlauth_email=#{email},nlauth_signature=#{signature}"
          end

          def determine_uri(uri, sandbox)
            URI((sandbox ? SANDBOX_API : PRODUCTION_API) + uri)
          end

          def encode(unencoded_string)
            CGI.escape(unencoded_string)
          end

        end
      end
    end
  end
end
