module NetSuite
  module Passports
    class User
      attr_reader :account, :email, :password, :role

      def initialize(account, email, password, role)
        @account = account
        @email = email
        @password = password
        @role = role
      end

      def passport
        {
          'platformMsgs:passport' => {
            'platformCore:account'  => account,
            'platformCore:email'    => email,
            'platformCore:password' => password,
            'platformCore:role'     => { :@internalId => role }
          }
        }
      end
    end
  end
end
