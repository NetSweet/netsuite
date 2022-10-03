module NetSuite
  module Utilities
    module Strings
      class << self
        def lower_camelcase(obj)
          str = obj.is_a?(String) ? obj.dup : obj.to_s
          str.gsub!(/\/(.?)/) { "::#{$1.upcase}" }
          str.gsub!(/(?:_+|-+)([a-z]|[0-9])/) { $1.upcase }
          str.gsub!(/(\A|\s)([A-Z])/) { $1 + $2.downcase }
          str
        end
      end
    end
  end
end