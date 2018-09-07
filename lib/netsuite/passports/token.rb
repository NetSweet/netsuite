module NetSuite
  module Passports
    class Token
      attr_reader :account, :consumer_key, :consumer_secret, :token_id, :token_secret

      ALPHANUMERICS = [*'0'..'9',*'A'..'Z',*'a'..'z'].freeze
      ALPHANUMERICS_SIZE = ALPHANUMERICS.size

      def initialize(account, consumer_key, consumer_secret, token_id, token_secret)
        @account = account.to_s
        @consumer_key = consumer_key
        @consumer_secret = consumer_secret
        @token_id = token_id
        @token_secret = token_secret
      end

      def passport
        {
          'platformMsgs:tokenPassport' => {
            'platformCore:account' => account,
            'platformCore:consumerKey' => consumer_key,
            'platformCore:token' => token_id,
            'platformCore:nonce' => nonce,
            'platformCore:timestamp' => timestamp,
            'platformCore:signature' => signature,
            :attributes! => { 'platformCore:signature' => { 'algorithm' => 'HMAC-SHA256' } }
          }
        }
      end

      private

      def signature
        Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), signature_key, signature_data))
      end

      def signature_key
        "#{consumer_secret}&#{token_secret}"
      end

      def signature_data
        "#{account}&#{consumer_key}&#{token_id}&#{nonce}&#{timestamp}"
      end

      def nonce
        # TODO use SecureRandom.alphanumeric(20) when minimum ruby version is upgraded
        # https://stackoverflow.com/questions/44466165/surprising-output-using-parallel-gem-with-srand-and-rand
        # shouldn't use sample, it relies on global state
        # https://bugs.ruby-lang.org/issues/10849
        # https://stackoverflow.com/questions/8567917/how-to-use-arraysamplen-random-rng-syntax

        @nonce ||= Array.new(40) { NetSuite::Passports::Token::ALPHANUMERICS[SecureRandom.random_number(NetSuite::Passports::Token::ALPHANUMERICS_SIZE)] }.join
      end

      def timestamp
        @timestamp ||= Time.now.to_i
      end
    end
  end
end
