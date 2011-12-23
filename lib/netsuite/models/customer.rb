module NetSuite
  class Customer

    def initialize(attributes = {})
      @attributes = attributes
    end

    def self.get(id)
      response = NetSuite::Actions::Get.call(id)
      if response.success?
        new(response.body)
      else
        raise RecordNotFound, "#{self} with ID=#{id} could not be found"
      end
    end

    def add
      response = NetSuite::Actions::Add.call(@attributes)
      response.success?
    end

    def method_missing(m, *args, &block)
      if @attributes.keys.include?(m.to_sym)
        @attributes[m.to_sym]
      else
        super
      end
    end

  end
end
