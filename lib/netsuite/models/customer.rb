module NetSuite
  class Customer

    def initialize(attributes = {})
      @attributes = attributes
    end

    def self.get(id)
      response = NetSuite::Actions::Customer::Get.call(id)
      if response.success?
        new(response.body)
      else
        raise RecordNotFound, "#{self} with ID=#{id} could not be found"
      end
    end

    def is_person
      @attributes[:is_person]
    end

  end
end
