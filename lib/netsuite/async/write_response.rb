module NetSuite
  module Async
    class WriteResponse

      attr_reader :base_ref, :status

      def initialize(write_result)
        @status = NetSuite::Status.new(write_result[:status])
        @base_ref = NetSuite::Records::RecordRef.new(write_result[:base_ref]) if write_result[:base_ref]
      end

      def success?
        @status.success?
      end

    end
  end
end
