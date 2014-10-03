module NetSuite
  module Records
    class MatrixOptionList
      # Deals with both hash and arrays of attributes[:matrix_option_list]
      #
      # Hash:
      #
      #   <listAcct:matrixOptionList>
      #     <listAcct:matrixOption internalId="47" scriptId="custitem15">
      #       <platformCore:value internalId="2" typeId="36"/>
      #     </listAcct:matrixOption>
      #   </listAcct:matrixOptionList>
      #
      # Array:
      #
      #   <listAcct:matrixOptionList>
      #     <listAcct:matrixOption internalId="45" scriptId="custitem13">
      #       <platformCore:value internalId="4" typeId="28"/>
      #     </listAcct:matrixOption>
      #     <listAcct:matrixOption internalId="46" scriptId="custitem14">
      #       <platformCore:value internalId="1" typeId="29"/>
      #     </listAcct:matrixOption>
      #   </listAcct:matrixOptionList>
      #
      def initialize(attributes = {})
        case attributes[:matrix_option]
        when Hash
          options << OpenStruct.new(
            type_id: attributes[:matrix_option][:value][:'@type_id'],
            value_id: attributes[:matrix_option][:value][:'@internal_id']
          )
        when Array
          attributes[:matrix_option].each do |option|
            options << OpenStruct.new(
              type_id: option[:value][:'@type_id'],
              value_id: option[:value][:'@internal_id']
            )
          end
        end
      end

      def options
        @options ||= []
      end
    end
  end
end
