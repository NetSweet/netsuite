module NetSuite
  module Actions
    class GetSelectValue
      include Support::Requests

      def initialize(klass, options = {})
        @klass   = klass
        @options = options
      end

      private

      def request(credentials={})
        NetSuite::Configuration.connection(
          {namespaces: {
            'xmlns:platformMsgs' => "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore' => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com"
          }}, credentials
        ).call :get_select_value, :message => @options
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:base_ref_list]
      end

      def response_hash
        @response_hash = @response.body[:get_select_value_response][:get_select_value_result]
      end

      module Support

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          def get_select_value(options = {}, credentials={})
            message = {
              pageIndex: (options.delete(:pageIndex) || 1),
              fieldDescription: field_description(options)
            }

            response = NetSuite::Actions::GetSelectValue.call([self, message], credentials)

            if response.success?
              new(response.body)
            else
              raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
            end
          end

          private
            # TODO this goes against the design of the rest of the gem; should be removed in the future
            def field_description(options)
              options.inject({}) do |h, (k, v)|
                h["platformCore:#{k}"] = v
                h
              end
            end

        end
      end

    end
  end
end
