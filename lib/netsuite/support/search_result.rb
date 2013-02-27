module NetSuite
  module Support
    class SearchResult
    	attr_accessor :attributes

    	def initialize(attributes)
    		@attributes = attributes
    	end
    end
  end
end