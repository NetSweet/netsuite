require 'uri'

module URI
    class << self
        def unescape(str)
            CGI.unescape(str)
        end

        def escape(str)
            CGI.escape(str)
        end
    end
end
