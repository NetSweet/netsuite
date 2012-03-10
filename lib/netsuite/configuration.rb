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

    def wsdl=(wsdl)
      attributes[:wsdl] = wsdl
    end

    def wsdl(wsdl = nil)
      if wsdl
        self.wsdl = wsdl
      else
        attributes[:wsdl] ||= File.expand_path('../../../wsdl/2011_02.wsdl', __FILE__)
      end
    end

    def auth_header
      attributes[:auth_header] ||= {
        'platformMsgs:passport' => {
          'platformCore:email'    => email,
          'platformCore:password' => password,
          'platformCore:account'  => account.to_s,
          'platformCore:role'     => role.to_record,
          :attributes! => {
            'platformCore:role' => role.attributes!
          }
        }
      }
    end
    
    def role=(role)
      attributes[:role] = NetSuite::Records::RecordRef.new(:internal_id => role, :type => 'role')
    end
    
    def role(role = nil)
      if role
        self.role = role
      else 
        attributes[:role] ||= NetSuite::Records::RecordRef.new(:internal_id => '3', :type => 'role')
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
