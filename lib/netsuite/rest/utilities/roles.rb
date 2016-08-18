require 'net/http'
require 'uri'
require 'json'

module NetSuite
  module Rest
    module Utilities
      class Roles

        ROLES_API = "https://rest.netsuite.com/rest/roles"

        def self.get(credentials)
          new(credentials).get
        end

        def initialize(credentials)
          @email     = encode_email(credentials.fetch(:email))
          @signature = credentials.fetch(:password)
        end

        def get
          response = make_request
          parsed   = JSON.parse(response.body)
          if reponse.code.to_i == 200
            extract(parsed)
          else
            parsed
          end
        end

        private

        def encode_email(unencoded_email)
          URI.escape(
            unencoded_email,
            Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")
          )
        end

        def make_request
          uri = URI(ROLES_API)
          request = Net::HTTP::Get.new(uri)
          request['AUTHORIZATION'] = "NLAuth " +
            "nlauth_email=#{@email},nlauth_signature=#{@signature}"

          http = Net::HTTP.new(uri.hostname, uri.port)
          http.use_ssl = true

          http.start {|http| http.request(request)}
        end

        def extract(parsed)
          # [
          #   {
          #    "account"=>{
          #      "internalId"=>"TSTDRV15",
          #      "name"=>"Honeycomb Mfg SDN (Leading)"},
          #    "role"=>{
          #      "internalId"=>3,
          #      "name"=>"Administrator"},
          #    "dataCenterURLs"=>{
          #      "webservicesDomain"=>"https://webservices.na1.netsuite.com",
          #      "restDomain"=>"https://rest.na1.netsuite.com",
          #      "systemDomain"=>"https://system.na1.netsuite.com"}
          #    },
          #   {
          #    "account"=>{
          #      "internalId"=>"TSTDRV15",
          #      "name"=>"Honeycomb Mfg SDN (Leading)"},
          #    "role"=>{
          #      "internalId"=>1074,
          #      "name"=>"Custom Role"},
          #   ....

          {
            accounts: parsed.map {|hash| hash["account"]["internalId"] }.uniq,
            roles:    parsed.map {|hash| hash["role"]["internalId"] }.uniq,
            wsdls:    parsed.map {|hash| hash["dataCenterURLs"]["webservicesDomain"] }.uniq,
          }
        end

      end
    end
  end
end
