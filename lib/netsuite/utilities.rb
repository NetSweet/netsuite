require 'date'

module NetSuite
  module Utilities
    extend self

    # TODO need structured logger for various statements

    def clear_cache!
      if NetSuite::Configuration.multi_tenant?
        Thread.current[:netsuite_gem_netsuite_get_record_cache] = {}
        Thread.current[:netsuite_gem_netsuite_find_record_cache] = {}
      else
        @netsuite_get_record_cache = {}
        @netsuite_find_record_cache = {}
      end

      DataCenter.clear_cache!
    end

    def netsuite_get_record_cache
      if NetSuite::Configuration.multi_tenant?
        Thread.current[:netsuite_gem_netsuite_get_record_cache] ||= {}
      else
        @netsuite_get_record_cache ||= {}
      end
    end

    def netsuite_find_record_cache
      if NetSuite::Configuration.multi_tenant?
        Thread.current[:netsuite_gem_netsuite_find_record_cache] ||= {}
      else
        @netsuite_find_record_cache ||= {}
      end
    end

    def append_memo(ns_record, added_memo, opts = {})
      opts[:skip_if_exists] ||= false

      memo_key = if ns_record.class == NetSuite::Records::Customer
        :comments
      else
        :memo
      end

      return if opts[:skip_if_exists] &&
        ns_record.send(memo_key) &&
        ns_record.send(memo_key).include?(added_memo)

      if ns_record.send(memo_key)
        ns_record.send(:"#{memo_key}=", "#{ns_record.send(memo_key)}. #{added_memo}")
      else
        ns_record.send(:"#{memo_key}=", added_memo.to_s)
      end

      ns_record
    end

    def netsuite_server_time
      server_time_response = NetSuite::Utilities.backoff { NetSuite::Configuration.connection.call(:get_server_time) }
      server_time_response.body[:get_server_time_response][:get_server_time_result][:server_time]
    end

    def netsuite_data_center_urls(account_id)
      data_center_call_response = NetSuite::Configuration.connection({
        # NOTE force a production WSDL so the sandbox settings are ignored
        #      as of 1/20/18 NS will start using the account ID to determine
        #      if a account is sandbox (123_SB1) as opposed to using a sandbox domain

        wsdl: 'https://webservices.netsuite.com/wsdl/v2017_2_0/netsuite.wsdl',

        # NOTE don't inherit default namespace settings, it includes the API version
        namespaces: {
          'xmlns:platformCore' => "urn:core_2017_2.platform.webservices.netsuite.com"
        },

        soap_header: {}
      }).call(:get_data_center_urls, message: {
        'platformMsgs:account' => account_id
      })

      if data_center_call_response.success?
        data_center_call_response.body[:get_data_center_urls_response][:get_data_center_urls_result][:data_center_urls]
      else
        false
      end
    end

    # TODO consider what to dop with this duplicate data center implementation
    def data_center_url(*args)
      DataCenter.get(*args)
    end

    def backoff(options = {})
      # TODO the default backoff attempts should be customizable the global config
      options[:attempts] ||= 8

      count = 0

      begin
        count += 1
        yield
      rescue StandardError => e
        exceptions_to_retry = [
          Errno::ECONNRESET,
          Errno::ETIMEDOUT,
          Errno::EHOSTUNREACH,
          EOFError,
          Wasabi::Resolver::HTTPError,
          Savon::SOAPFault,
          Savon::InvalidResponseError,
          Zlib::BufError,
          Savon::HTTPError,
          SocketError,
          Net::OpenTimeout
        ]

        # available in ruby > 1.9
        if defined?(Net::ReadTimeout)
          exceptions_to_retry << Net::ReadTimeout
        end

        # available in ruby > 2.2.0
        exceptions_to_retry << IO::EINPROGRESSWaitWritable if defined?(IO::EINPROGRESSWaitWritable)
        exceptions_to_retry << OpenSSL::SSL::SSLErrorWaitReadable if defined?(OpenSSL::SSL::SSLErrorWaitReadable)

        # depends on the http library chosen
        exceptions_to_retry << HTTPI::SSLError if defined?(HTTPI::SSLError)
        exceptions_to_retry << HTTPI::TimeoutError if defined?(HTTPI::TimeoutError)
        exceptions_to_retry << HTTPClient::TimeoutError if defined?(HTTPClient::TimeoutError)
        exceptions_to_retry << HTTPClient::ConnectTimeoutError if defined?(HTTPClient::ConnectTimeoutError)
        exceptions_to_retry << HTTPClient::ReceiveTimeoutError if defined?(HTTPClient::ReceiveTimeoutError)
        exceptions_to_retry << HTTPClient::SendTimeoutError if defined?(HTTPClient::SendTimeoutError)
        exceptions_to_retry << Excon::Error::Timeout if defined?(Excon::Error::Timeout)
        exceptions_to_retry << Excon::Error::Socket if defined?(Excon::Error::Socket)

        if !exceptions_to_retry.include?(e.class)
          raise
        end

        # whitelist certain SOAPFaults; all other network errors should automatically retry
        if e.is_a?(Savon::SOAPFault)
          # https://github.com/stripe/stripe-netsuite/issues/815
          if !e.message.include?("Only one request may be made against a session at a time") &&
            !e.message.include?('java.util.ConcurrentModificationException') &&
            !e.message.include?('java.lang.NullPointerException') &&
            !e.message.include?('java.lang.IllegalStateException') &&
            !e.message.include?('java.lang.reflect.InvocationTargetException') &&
            !e.message.include?('com.netledger.common.exceptions.NLDatabaseOfflineException') &&
            !e.message.include?('com.netledger.database.NLConnectionUtil$NoCompanyDbsOnlineException') &&
            !e.message.include?('com.netledger.cache.CacheUnavailableException') &&
            !e.message.include?('java.lang.IllegalStateException') &&
            !e.message.include?('An unexpected error occurred.') &&
            !e.message.include?('An unexpected error has occurred.  Technical Support has been alerted to this problem.') &&
            !e.message.include?('Session invalidation is in progress with different thread') &&
            !e.message.include?('[missing resource APP:ERRORMESSAGE:WS_AN_UNEXPECTED_ERROR_OCCURRED] [missing resource APP:ERRORMESSAGE:ERROR_ID_1]') &&
            !e.message.include?('SuiteTalk concurrent request limit exceeded. Request blocked.') &&
            # maintenance is the new outage: this message is being used for intermittent errors
            !e.message.include?('The account you are trying to access is currently unavailable while we undergo our regularly scheduled maintenance.') &&
            !e.message.include?('The Connection Pool is not intialized.') &&
            # it looks like NetSuite mispelled their error message...
            !e.message.include?('The Connection Pool is not intiialized.')
            raise
          end
        end

        if count >= options[:attempts]
          raise
        end

        # log.warn("concurrent request failure", sleep: count, attempt: count)
        sleep(count)

        retry
      end
    end

    def request_failed?(ns_object)
      return false if ns_object.errors.nil? || ns_object.errors.empty?
      ns_object.errors.any? { |x| x.type == "ERROR" }
    end

    def get_field_options(recordType, fieldName)
      options = NetSuite::Records::BaseRefList.get_select_value(
        field: fieldName,
        recordType: recordType
      )

      options.base_refs
    end

    def get_item(ns_item_internal_id, opts = {})
      # TODO add additional item types!
      ns_item = NetSuite::Utilities.get_record(NetSuite::Records::InventoryItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::AssemblyItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::NonInventorySaleItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::NonInventoryResaleItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::DiscountItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::OtherChargeSaleItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::ServiceSaleItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::ServiceResaleItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::GiftCertificateItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::KitItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::ItemGroup, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::SerializedInventoryItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::SerializedAssemblyItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::LotNumberedAssemblyItem, ns_item_internal_id, opts)
      ns_item ||= NetSuite::Utilities.get_record(NetSuite::Records::LotNumberedInventoryItem, ns_item_internal_id, opts)

      if ns_item.nil?
        fail NetSuite::RecordNotFound, "item with ID #{ns_item_internal_id} not found"
      end

      ns_item
    end

    def get_record(record_klass, id, opts = {})
      opts[:external_id] ||= false

      if opts[:cache]
        netsuite_get_record_cache[record_klass.to_s] ||= {}

        if netsuite_get_record_cache[record_klass.to_s].has_key?(id.to_i)
          return netsuite_get_record_cache[record_klass.to_s][id.to_i]
        end
      end

      begin
        # log.debug("get record", netsuite_record_type: record_klass.name, netsuite_record_id: id)

        ns_record = if opts[:external_id]
          backoff { record_klass.get(external_id: id) }
        else
          backoff { record_klass.get(id) }
        end

        if opts[:cache]
          netsuite_get_record_cache[record_klass.to_s][id.to_i] = ns_record
        end

        return ns_record
      rescue ::NetSuite::RecordNotFound
        # log.warn("record not found", ns_record_type: record_klass.name, ns_record_id: id)
        if opts[:cache]
          netsuite_get_record_cache[record_klass.to_s][id.to_i] = nil
        end

        return nil
      end
    end

    def find_record(record, names, opts = {})
      field_name = opts[:field_name]

      names = [ names ] if names.is_a?(String)

      # FIXME: Records that have the same name but different types will break
      # the cache
      names.each do |name|
        if netsuite_find_record_cache.has_key?(name)
          return netsuite_find_record_cache[name]
        end

        # sniff for an email-like input; useful for employee/customer searches
        if !field_name && /@.*\./ =~ name
          field_name = 'email'
        end

        field_name ||= if record.to_s.end_with?('Item')
          'displayName'
        else
          'name'
        end

        # TODO remove backoff when it's built-in to search
        search = backoff { record.search({
          basic: [
            {
              field: field_name,
              operator: 'contains',
              value: name,
            }
          ]
        }) }

        if search.results.first
          return netsuite_find_record_cache[name] = search.results.first
        end
      end

      nil
    end

    # http://mikebian.co/notes-on-dates-timezones-with-netsuites-suitetalk-api/
    # https://wyeworks.com/blog/2016/6/22/behavior-changes-in-ruby-2.4
    # https://github.com/rails/rails/commit/c9c5788a527b70d7f983e2b4b47e3afd863d9f48

    # assumes UTC0 unix timestamp
    def normalize_time_to_netsuite_date(unix_timestamp)
      # convert to date to eliminate hr/min/sec
      time = Time.at(unix_timestamp).
        utc.
        to_date.
        to_datetime

      # tzinfo allows us to determine the dst status of the time being passed in
      # NetSuite requires that the time be passed to the API with the PDT TZ offset
      # of the time passed in (i.e. not the current TZ offset of PDT)

      if defined?(TZInfo)
        # if no version is defined, less than 2.0
        # https://github.com/tzinfo/tzinfo/blob/master/CHANGES.md#added
        if !defined?(TZInfo::VERSION)
          # https://stackoverflow.com/questions/2927111/ruby-get-time-in-given-timezone
          offset = TZInfo::Timezone.get("America/Los_Angeles").period_for_utc(time).utc_total_offset_rational
          time = time.new_offset(offset)
        else
          time = TZInfo::Timezone.get("America/Los_Angeles").utc_to_local(time)
          offset = time.offset
        end
      else
        # if tzinfo is not installed, let's give it our best guess: -7
        offset = Rational(-7, 24)
        time = time.new_offset("-07:00")
      end

      time = (time + (offset * -1))
      time.iso8601
    end

  end
end
