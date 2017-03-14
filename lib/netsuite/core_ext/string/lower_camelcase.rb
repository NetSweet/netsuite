class String
  def lower_camelcase
    str = dup
    str.gsub!(/\/(.?)/) { "::#{$1.upcase}" }
    str.gsub!(/(?:_+|-+)([a-z]|[0-9])/) { $1.upcase }
    str.gsub!(/(\A|\s)([A-Z])/) { $1 + $2.downcase }
    str
  end
end
