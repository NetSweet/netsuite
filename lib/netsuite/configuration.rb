module NetSuite
  module Configuration
    extend self

    def reset!
      attributes.clear
    end

    def attributes
      @attributes ||= {}
    end

    def connection(params={}, credentials={})
      Savon.client({
        wsdl: credentials[:wsdl].present? ? credentials[:wsdl] : wsdl,
        read_timeout: read_timeout,
        namespaces: namespaces,
        soap_header: auth_header(credentials).update(soap_header),
        pretty_print_xml: true,
        filters: filters,
        logger: logger,
        log_level: log_level,
        log: !silent, # turn off logging entirely if configured
      }.update(params))
    end

    def filters(list = nil)
      if list
        self.filters = list
      else
        attributes[:filters] ||= [
          :password,
          :email,
          :consumerKey,
          :token
        ]
      end
    end

    def filters=(list)
      attributes[:filters] = list
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

    def sandbox=(flag)
      attributes[:flag] = flag
    end

    def sandbox(flag = nil)
      if flag.nil?
        attributes[:flag] ||= false
      else
        self.sandbox = flag
      end
    end

    def sandbox?
      !!sandbox
    end

    def wsdl=(wsdl)
      attributes[:wsdl] = wsdl
    end

    def wsdl(wsdl = nil)
      if wsdl
        self.wsdl = wsdl
      else
        attributes[:wsdl] ||= begin
          if sandbox
            "https://webservices.sandbox.netsuite.com/wsdl/v#{api_version}_0/netsuite.wsdl"
          else
            wsdl_path = File.expand_path("../../../wsdl/#{api_version}.wsdl", __FILE__)

            unless File.exists? wsdl_path
              wsdl_path = "https://#{wsdl_domain}/wsdl/v#{api_version}_0/netsuite.wsdl"
            end

            wsdl_path
          end
        end
      end
    end

    def wsdl_domain(wsdl_domain = nil)
      if wsdl_domain
        self.wsdl_domain = wsdl_domain
      else
        # if sandbox, this parameter is ignored
        if sandbox
          'webservices.sandbox.netsuite.com'
        else
          attributes[:wsdl_domain] ||= 'webservices.netsuite.com'
        end
      end
    end

    def wsdl_domain=(wsdl_domain)
      attributes[:wsdl_domain] = wsdl_domain
    end

    def soap_header=(headers)
      attributes[:soap_header] = headers
    end

    def soap_header(headers = nil)
      if headers
        self.soap_header = headers
      else
        attributes[:soap_header] ||= {}
      end
    end

    def auth_header(credentials={})
      if !credentials[:consumer_key].blank? || !consumer_key.blank?
        token_auth(credentials)
      else
        user_auth(credentials)
      end
    end

    def user_auth(credentials)
      NetSuite::Passports::User.new(
        credentials[:account] || account,
        credentials[:email] || email,
        credentials[:password] || password,
        credentials[:role] || role
      ).passport
    end

    def token_auth(credentials)
      NetSuite::Passports::Token.new(
        credentials[:account] || account,
        credentials[:consumer_key] || consumer_key,
        credentials[:consumer_secret] || consumer_secret,
        credentials[:token_id] || token_id,
        credentials[:token_secret] || token_secret
      ).passport
    end

    def namespaces
      {
        'xmlns:platformMsgs'   => "urn:messages_#{api_version}.platform.webservices.netsuite.com",
        'xmlns:platformCore'   => "urn:core_#{api_version}.platform.webservices.netsuite.com",
        'xmlns:platformCommon' => "urn:common_#{api_version}.platform.webservices.netsuite.com",
        'xmlns:listRel'        => "urn:relationships_#{api_version}.lists.webservices.netsuite.com",
        'xmlns:tranSales'      => "urn:sales_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:tranPurch'      => "urn:purchases_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:actSched'       => "urn:scheduling_#{api_version}.activities.webservices.netsuite.com",
        'xmlns:setupCustom'    => "urn:customization_#{api_version}.setup.webservices.netsuite.com",
        'xmlns:listAcct'       => "urn:accounting_#{api_version}.lists.webservices.netsuite.com",
        'xmlns:tranBank'       => "urn:bank_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:tranCust'       => "urn:customers_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:tranEmp'        => "urn:employees_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:tranInvt'       => "urn:inventory_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:listSupport'    => "urn:support_#{api_version}.lists.webservices.netsuite.com",
        'xmlns:tranGeneral'    => "urn:general_#{api_version}.transactions.webservices.netsuite.com",
        'xmlns:listMkt'        => "urn:marketing_#{api_version}.lists.webservices.netsuite.com",
        'xmlns:listWebsite'    => "urn:website_#{api_version}.lists.webservices.netsuite.com",
        'xmlns:fileCabinet'    => "urn:filecabinet_#{api_version}.documents.webservices.netsuite.com",
        'xmlns:listEmp'        => "urn:employees_#{api_version}.lists.webservices.netsuite.com"
      }
    end

    def role=(role)
      attributes[:role] = role
    end

    def role(role = nil)
      if role
        self.role = role
      else
        attributes[:role] ||= '3'
      end
    end

    def email=(email)
      attributes[:email] = email
    end

    def email(email = nil)
      if email
        self.email = email
      else
        attributes[:email]
      end
    end

    def password=(password)
      attributes[:password] = password
    end

    def password(password = nil)
      if password
        self.password = password
      else
        attributes[:password]
      end
    end

    def account=(account)
      attributes[:account] = account
    end

    def account(account = nil)
      if account
        self.account = account
      else
        attributes[:account]
      end
    end

    def consumer_key=(consumer_key)
      attributes[:consumer_key] = consumer_key
    end

    def consumer_key(consumer_key = nil)
      if consumer_key
        self.consumer_key = consumer_key
      else
        attributes[:consumer_key]
      end
    end

    def consumer_secret=(consumer_secret)
      attributes[:consumer_secret] = consumer_secret
    end

    def consumer_secret(consumer_secret = nil)
      if consumer_secret
        self.consumer_secret = consumer_secret
      else
        attributes[:consumer_secret]
      end
    end

    def token_id=(token_id)
      attributes[:token_id] = token_id
    end

    def token_id(token_id = nil)
      if token_id
        self.token_id = token_id
      else
        attributes[:token_id]
      end
    end

    def token_secret=(token_secret)
      attributes[:token_secret] = token_secret
    end

    def token_secret(token_secret = nil)
      if token_secret
        self.token_secret = token_secret
      else
        attributes[:token_secret]
      end
    end

    def read_timeout=(timeout)
      attributes[:read_timeout] = timeout
    end

    def read_timeout(timeout = nil)
      if timeout
        self.read_timeout = timeout
      else
        attributes[:read_timeout] ||= 60
      end
    end

    def log=(path)
      attributes[:log] = path
    end

    def log(path = nil)
      self.log = path if path
      attributes[:log]
    end

    def logger(value = nil)
      attributes[:logger] = if value.nil?
        ::Logger.new((log && !log.empty?) ? log : $stdout)
      else
        value
      end
    end

    def silent(value=nil)
      self.silent = value if !value.nil?
      attributes[:silent]
    end

    def silent=(value)
      attributes[:silent] ||= value
    end

    def log_level(value = nil)
      self.log_level = value || :debug
      attributes[:log_level]
    end

    def log_level=(value)
      attributes[:log_level] ||= value
    end
  end
end
