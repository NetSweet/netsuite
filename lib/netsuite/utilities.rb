module NetSuite
  module Utilities
    extend self

    # TODO need structured logger for various statements

    def backoff(options = {})
      count = 0
      begin
        count += 1
        yield
      rescue options[:exception] || Savon::SOAPFault => e
        if !e.message.include?("Only one request may be made against a session at a time")
          raise e
        end
        if count >= (options[:attempts] || 8)
          raise e
        end
        # log.warn("concurrent request failure", sleep: count, attempt: count)
        sleep(count)
        retry
      end
    end

    def request_failed?(ns_object)
      return false if ns_object.errors.nil? || ns_object.errors.empty?

      warnings = ns_object.errors.select { |x| x.type == "WARN" }
      errors = ns_object.errors.select { |x| x.type == "ERROR" }

      # warnings.each do |warn|
      #   log.warn(warn.message, code: warn.code)
      # end

      return errors.size > 0
    end

    def get_record(record_klass, id, external_id: false)
      begin
        # log.debug("get record", netsuite_record_type: record_klass.name, netsuite_record_id: id)

        if external_id
          return backoff { record_klass.get(external_id: id) }
        else
          return backoff { record_klass.get(id) }
        end
      rescue ::NetSuite::RecordNotFound
        # log.warn("record not found", ns_record_type: record_klass.name, ns_record_id: id)
        return nil
      end
    end

    def find_record(record, names, field_name: nil)
      names = [ names ] if names.is_a?(String)

      # FIXME: Records that have the same name but different types will break
      # the cache
      names.each do |name|
        @netsuite_find_record_cache ||= {}

        if @netsuite_find_record_cache.has_key?(name)
          return @netsuite_find_record_cache[name]
        end

        # sniff for an email-like input; useful for employee/customer searches
        if !field_name && /@.*\./ =~ name
          field_name = 'email'
        end

        field_name ||= 'name'

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
          return @netsuite_find_record_cache[name] = search.results.first
        end
      end

      nil
    end

    def data_center_url(netsuite_account)
      begin
        data_center_call_response = NetSuite::Configuration.connection({}, {
          email: '',
          password: '',
          account: ''
        }).call(:get_data_center_urls, message: {
          'platformMsgs:account' => netsuite_account
        })

        if data_center_call_response.success?
          return data_center_call_response.body[:get_data_center_urls_response][:get_data_center_urls_result][:data_center_urls][:webservices_domain]
        else
          # log.error "error getting data center url"
        end
      rescue Exception => e
        # log.error "error determining correct datacenter for account #{netsuite_account}. #{e.message}"

        # TODO silence this later: for now we need to investigate when this would occur
        raise(e)
      end
    end

    # Warning this was developed with a Web Services user whose time zone was set to CST
    # the time zone setting of the user seems to effect how times work in NS

    # modifying time without rails:
    # http://stackoverflow.com/questions/238684/subtract-n-hours-from-a-datetime-in-ruby

    # converting between time and datetime:
    # http://stackoverflow.com/questions/279769/convert-to-from-datetime-and-time-in-ruby

    # use when sending times to NS
    def normalize_datetime_to_netsuite(datetime)
      # normalize the time to UCT0
      # add 6 hours (21600 seconds) of padding (CST offset)
      # to force the same time to be displayed in the NS UI

      is_dst = Time.parse(datetime.to_s).dst?

      datetime.new_offset(0) + datetime.offset + Rational(is_dst ? 5 : 6, 24)
    end

    # use when displaying times from a NS record
    def normalize_datetime_from_netsuite(datetime)
      # the code below eliminates the TimeZone offset then shifts the date forward 2 hours (7200 seconds)
      # this ensures that ActiveRecord is given a UTC0 DateTime with the exact hour that
      # was displayed in the NS UI (CST time zone), which will result in the correct display on the web side

      datetime.new_offset(0) + datetime.offset + Rational(2, 24)
    end

  end
end
