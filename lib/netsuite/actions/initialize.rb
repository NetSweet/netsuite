# https://system.netsuite.com/help/helpcenter/en_US/Output/Help/SuiteCloudCustomizationScriptingWebServices/SuiteTalkWebServices/initializeinitializeList.html
module NetSuite
  module Actions
    class Initialize
      include Support::Requests

      def initialize(klass, object)
        @klass  = klass
        @object = object
      end

      def request(credentials={})
        NetSuite::Configuration.connection(
          {namespaces: {
            'xmlns:platformMsgs'    => "urn:messages_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCore'    => "urn:core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
            'xmlns:platformCoreTyp' => "urn:types.core_#{NetSuite::Configuration.api_version}.platform.webservices.netsuite.com",
          }}, credentials
        ).call :initialize, :message => request_body
      end

      # <platformMsgs:initializeRecord>
      #   <platformCore:type>invoice</platformCore:type>
      #   <platformCore:reference internalId="1513" type="salesOrder">
      #     <platformCore:name>1511</platformCore:name>
      #   </platformCore:reference>
      # </platformMsgs:initializeRecord>
      def request_body
        {
          'platformMsgs:initializeRecord' => {
            'platformCore:type'      => NetSuite::Support::Records.netsuite_type(@klass),
            'platformCore:reference' => {},
            :attributes!             => {
              'platformCore:reference' => {
                'internalId' => @object.internal_id,
                :type        => NetSuite::Support::Records.netsuite_type(@object)
              }
            }
          }
        }
      end

      def response_hash
        @response_hash ||= @response.to_hash[:initialize_response][:read_response]
      end

      def success?
        @success ||= response_hash[:status][:@is_success] == 'true'
      end

      def response_body
        @response_body ||= response_hash[:record]
      end

      module Support

        def self.included(base)
          (class << base; self; end).instance_eval do # We have to do this because Class has a private
            define_method :initialize do |*args|      # #initialize method that this method will override.
              super(*args)
            end
          end
          base.extend(ClassMethods)
        end

        module ClassMethods

          def initialize(object, credentials={})
            response = NetSuite::Actions::Initialize.call([self, object], credentials)
            if response.success?
              new(response.body)
            else
              raise InitializationError, "#{self}.initialize with #{object} failed."
            end
          end

        end
      end

    end
  end
end
