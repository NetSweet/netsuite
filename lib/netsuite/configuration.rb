module NetSuite
  module Configuration
    extend self

    def reset!
      attributes.clear
    end

    def attributes
      @attributes ||= {}
    end

    def connection
      attributes[:connection] ||= Savon::Client.new(self.wsdl)
    end

    def wsdl
      attributes[:wsdl] ||= File.expand_path('../../../wsdl/2011_02.wsdl', __FILE__)
    end

    def auth_header
      attributes[:auth_header] ||= {
        'platformMsgs:passport' => {
          'platformCore:email'    => email,
          'platformCore:password' => password,
          'platformCore:account'  => account.to_s
        }
      }
    end

    def email=(email)
      attributes[:email] = email
    end

    def email(email = nil)
      if email
        self.email = email
      else
        attributes[:email] ||
        raise(NetSuite::ConfigurationError,
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
        raise(NetSuite::ConfigurationError,
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
        raise(NetSuite::ConfigurationError,
          '#account is a required configuration value. Please set it by calling NetSuite::Configuration.account = 1234')
      end
    end

  end
end
