module NetSuite
  module Utilities
    class DataCenter
      class << self

        def clear_cache!
          @cache = {}
        end

        def get(netsuite_account, opts = {})
          if opts[:cache] && wsdl=fetch_from_cache(netsuite_account)
            return wsdl
          end

          response = make_data_center_call(netsuite_account)
          if response.success?
            wsdl = extract_wsdl_from_response(response)
            cache[netsuite_account.to_s] = wsdl if opts[:cache]
            return wsdl
          else
            return nil
          end
        end

        private

          def cache
            @cache ||= {}
          end

          def make_data_center_call(netsuite_account)
            NetSuite::Configuration.connection({}, {
              email: '',
              password: '',
              account: ''
            }).call(:get_data_center_urls, message: {
              'platformMsgs:account' => netsuite_account
            })
            # allow errors to bubble up, log if patterns emerge
          end

          def fetch_from_cache(netsuite_account)
            return cache.fetch(netsuite_account.to_s, nil)
          end

          def extract_wsdl_from_response(response)
            response.body
              .fetch(:get_data_center_urls_response)
              .fetch(:get_data_center_urls_result)
              .fetch(:data_center_urls)
              .fetch(:webservices_domain)
          end

      end
    end
  end
end
