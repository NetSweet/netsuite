module NetSuite
  module Configuration
    extend self

    READ_TIMEOUT = 1000

    def reset!
      attributes.clear
    end

    def attributes
      @attributes ||= {}
    end

    def connection
      unless attributes[:connection]
        attributes[:connection] = Savon::Client.new(self.wsdl)

        attributes[:connection].http.read_timeout = READ_TIMEOUT
      end
      attributes[:connection].http.headers.delete("Cookie")
      attributes[:connection]
    end

    def api_version(version = nil)
      if version
        self.api_version = version
      else
        attributes[:api_version] ||= '2011_2'
      end
    end

    def api_version=(version)
      attributes[:api_version] = version
    end

    def wsdl=(wsdl)
      attributes[:wsdl] = wsdl
    end

    def wsdl(wsdl = nil)
      if wsdl
        self.wsdl = wsdl
      else
        attributes[:wsdl] ||= File.expand_path("../../../wsdl/#{api_version}.wsdl", __FILE__)
      end
    end

    def auth_header
      auth_header_hash = {
        'platformMsgs:passport' => {
          'platformCore:email'    => email,
          'platformCore:password' => password,
          'platformCore:account'  => account.to_s
        }
      }
      if role
        auth_header_hash['platformMsgs:passport'].merge!('platformCore:role' => role.to_record,
          :attributes! => {
            'platformCore:role' => role.attributes!
        })
      end
      attributes[:auth_header] ||= auth_header_hash
    end

    def role=(role)
      attributes[:role] = NetSuite::Records::RecordRef.new(:internal_id => role, :type => 'role')
    end

    def role(role = nil)
      if role
        self.role = role
      else
        attributes[:role] ||
        raise(ConfigurationError,
          '#role is a required configuration value. Please set it by calling NetSuite::Configuration.role = 5') 
      end

    end

    def email=(email)
      attributes[:email] = email
    end

    def email(email = nil)
      if email
        self.email = email
      else
        attributes[:email] ||
        raise(ConfigurationError,
          '#email is a required configuration value. Please set it by calling NetSuite::Configuration.email = "me@example.com"')
      end
    end

    def password=(password)
      attributes[:password] = password
    end

    def password(password = nil)
      if password
        self.password = password
      else
        attributes[:password] ||
        raise(ConfigurationError,
          '#password is a required configuration value. Please set it by calling NetSuite::Configuration.password = "my_pass"')
      end
    end

    def account=(account)
      attributes[:account] = account
    end

    def account(account = nil)
      if account
        self.account = account
      else
        attributes[:account] ||
        raise(ConfigurationError,
          '#account is a required configuration value. Please set it by calling NetSuite::Configuration.account = 1234')
      end
    end

  end
end
