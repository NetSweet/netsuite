module NetSuite
  module Records
    class MatrixOptionList
      include Namespaces::ListAcct

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
      #       <platformCore:value internalId="4" typeId="28">
      #         <platformCore:name>foo</platformCore:name>
      #       </platformCore:value>
      #     </listAcct:matrixOption>
      #     <listAcct:matrixOption internalId="46" scriptId="custitem14">
      #       <platformCore:value internalId="1" typeId="29">
      #         <platformCore:name>bar</platformCore:name>
      #       </platformCore:value>
      #     </listAcct:matrixOption>
      #   </listAcct:matrixOptionList>
      #
      def initialize(attributes = {})
        case attributes[:matrix_option]
        when Hash
          options << OpenStruct.new(
            type_id: attributes[:matrix_option][:value][:'@type_id'],
            value_id: attributes[:matrix_option][:value][:'@internal_id'],
            script_id: attributes[:matrix_option][:@script_id],
            name: attributes[:matrix_option][:value][:name]
          )
        when Array
          attributes[:matrix_option].each do |option|
            options << OpenStruct.new(
              type_id: option[:value][:'@type_id'],
              value_id: option[:value][:'@internal_id'],
              script_id: option[:@script_id],
              name: option[:value][:name]
            )
          end
        end
      end

      def options
        @options ||= []
      end

      def to_record
        {
          "#{record_namespace}:matrixOption" => options.map do |option|
            {
              'platformCore:value' => {
                '@internalId' => option.value_id,
                '@typeId' => option.type_id,
              },
              '@scriptId' => option.script_id
            }
          end
        }
      end
    end
  end
end
