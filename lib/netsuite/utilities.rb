module NetSuite
  module Utilities

    # Warning this was developed with a Web Services user whose time zone was set to CST
    # the time zone setting of the user seems to effect how times work in NS

    # modifying time without rails:
    # http://stackoverflow.com/questions/238684/subtract-n-hours-from-a-datetime-in-ruby

    # converting between time and datetime:
    # http://stackoverflow.com/questions/279769/convert-to-from-datetime-and-time-in-ruby

    # use when sending times to NS
    def self.normalize_datetime_to_netsuite(datetime)
      # normalize the time to UCT0
      # add 6 hours (21600 seconds) of padding (CST offset)
      # to force the same time to be displayed in the NS UI

      is_dst = Time.parse(datetime.to_s).dst?

      datetime.new_offset(0) + datetime.offset + Rational(is_dst ? 5 : 6, 24)
    end

    # use when displaying times from a NS record
    def self.normalize_datetime_from_netsuite(datetime)
      # the code below eliminates the TimeZone offset then shifts the date forward 2 hours (7200 seconds)
      # this ensures that ActiveRecord is given a UTC0 DateTime with the exact hour that
      # was displayed in the NS UI (CST time zone), which will result in the correct display on the web side

      datetime.new_offset(0) + datetime.offset + Rational(2, 24)
    end

  end
end
