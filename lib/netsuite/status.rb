module NetSuite
  class StatusDetail < NetSuite::Error; end

  class Status

    attr_reader :is_success, :details

    def initialize(status)
      @is_success = status[:@is_success] == 'true'
      @details = status[:status_detail] ? Array[status[:status_detail]].flatten.map { |d| NetSuite::StatusDetail.new(d) } : []
    end

    def success?
      @is_success
    end

  end
end
