module NetSuite
  module Records
    class MatrixOptionList
      def initialize(attributes = {})
        attributes[:matrix_option].each do |option|
          options << OpenStruct.new(
            type_id: option[:value][:'@type_id'],
            value_id: option[:value][:'@internal_id']
          )
        end if attributes[:matrix_option]
      end

      def options
        @options ||= []
      end
    end
  end
end
