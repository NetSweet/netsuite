require 'net/http'
require 'uri'
require 'json'

module NetSuite
  module Rest
    module Utilities
      class Roles

        ROLES_API = "https://rest.netsuite.com/rest/roles"

        def self.get(*args)
          new(*args).get
        end

        def initialize(credentials)
          @email     = encode(credentials.fetch :email)
          @signature = encode(credentials.fetch :password)
        end

        def get
          response = make_request
          parsed   = JSON.parse(response.body)
          response.code == "200" ? extract(parsed) : parsed
        end

        private

        def encode(unencoded_string)
          URI.escape(
            unencoded_string,
            /[#{URI::PATTERN::RESERVED}]/
          )
        end

        def make_request
          uri = URI(ROLES_API)
          get = Net::HTTP::Get.new(uri)
          get['AUTHORIZATION'] = "NLAuth " +
            "nlauth_email=#{@email}," +
            "nlauth_signature=#{@signature}"

          http = Net::HTTP.new(uri.hostname, uri.port)
          http.use_ssl = true
          http.read_timeout = 30
          http.start {|http| http.request(get)}
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
