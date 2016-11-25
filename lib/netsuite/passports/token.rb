module NetSuite
  module Passports
    class Token
      attr_reader :account, :consumer_key, :consumer_secret, :token_id, :token_secret

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
        @nonce ||= Array.new(20) { alphanumerics.sample }.join
      end

      def alphanumerics
        [*'0'..'9',*'A'..'Z',*'a'..'z']
      end

      def timestamp
        @timestamp ||= Time.now.to_i
      end
    end
  end
end
