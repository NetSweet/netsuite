
module NetSuite
  module Records
    class NullFieldList #< Support::Sublist
      #include Support::Records
      include Support::Fields
      include Namespaces::PlatformCore

      field :name, Name

      #alias :names :name

      #fields :name

      def initialize(attributes={})
        binding.pry
        @name = attributes#[:name]
      end

      def name
        @name
      end

    end
  end
end
# module NetSuite
#   module Records
#     class NullFieldList
#       include Support::Fields
#       include Namespaces::PlatformCore

#       field :name
    
#       def initialize(attributes = {})
#         binding.pry
#         case attributes[:name]
#         when Hash
#           extract_name(attributes[:name])
#         when Array
#           attributes[:name].each { |name| extract_name(name) }
#         end

#         @names_assoc = Hash.new
#         names.each do |name|

#           if reference_id = name.send(reference_id_type)
#             @names_assoc[reference_id.to_sym] = name
#           end
#         end
#       end

#       def names
#         @names ||= []
#       end

#       def delete_name(field)
#         names.delete_if do |c|
#           c.send(reference_id_type) &&
#             c.send(reference_id_type).to_sym == field
#         end

#         @names_assoc.delete(field)
#       end

#       def method_missing(sym, *args, &block)
#         # read null field if already set
#         if @names_assoc.include?(sym)
#           return @names_assoc[sym]
#         end

#         # write null field
#         if sym.to_s.end_with?('=')
#           field_name = sym.to_s[0..-2]
#           delete_name(field_name.to_sym)
#           return create_name(field_name, args.first)
#         end

#         super(sym, *args, &block)
#       end

#       def respond_to?(sym, include_private = false)
#         return true if @names_assoc.include?(sym)
#         super
#       end

#       def to_record
#         binding.pry
#         {
#           "#{record_namespace}:name" => names.map do |name|
#             # if name.value.respond_to?(:to_record)
#             #   name_value = name.value.to_record
#             # elsif name.value.is_a?(Array)
#             #   name_value = name.value.map(&:to_record)
#             # else
#               name_value = name.value.to_s
#             # end
#             binding.pry
#             base = {
#               "platformCore:value" => name_value,
#               '@xsi:type' => name.type
#             }

#             # TODO this is broken in > 2013_1; need to conditionally change the synax here
#             # if NetSuite::Configuration.api_version < "2013_2"

#             # if name.internal_id
#             #   base['@internalId'] = name.internal_id
#             # end

#             # binding.pry
#             # if name.script_id
#             #   base['@scriptId'] = name.script_id
#             # end

#             base
#           end
#         }
#       end

#       private

#         def reference_id_type
#           @reference_id_type ||= Configuration.api_version >= '2013_2' ? :script_id : :internal_id
#         end

#         def extract_name(name_data)
#           binding.pry
#           # if name_data.kind_of?(Name)
#           #   binding.pry
#              names << name_data
#           # else
#           #   binding.pry
#           #   attrs = name_data.clone
#           #   type = (name_data[:"@xsi:type"] || name_data[:type])

#           #   if type == "platformCore:SelectNullFieldRef"
#           #     attrs[:value] = NullRecordRef.new(name_data[:value])
#           #   elsif type == 'platformCore:MultiSelectNullFieldRef'
#           #     # if only one value of multiselect is selected it will be a hash, not an array
#           #     if attrs[:value].is_a?(Array)
#           #       attrs[:value] = name_data[:value].map { |entry| NullRecordRef.new(entry) }
#           #     else
#           #       attrs[:value] = NullRecordRef.new(name_data[:value])
#           #     end
#           #   end
#           #   names << Name.new(attrs)

#           #end
#         end

#         def create_name(reference_id, field_value)
#           # all null fields need types; infer type based on class sniffing
#           field_type = case
#           when field_value.is_a?(Array)
#             'MultiSelectNullFieldRef'
#           when field_value.is_a?(Hash),
#                field_value.is_a?(NetSuite::Records::NullRecordRef)
#             'SelectNullFieldRef'
#           when field_value.is_a?(DateTime),
#                field_value.is_a?(Time),
#                field_value.is_a?(Date)
#             'DateNullFieldRef'
#           when field_value.is_a?(FalseClass),
#                field_value.is_a?(TrueClass)
#             'BooleanNullFieldRef'
#           else
#             'StringNullFieldRef'
#           end

#           # TODO seems like DateTime doesn't need the iso8601 call
#           #      not sure if this is specific to my env though

#           name_value = case
#           when field_value.is_a?(Hash)
#             NullRecordRef.new(field_value)
#           when field_value.is_a?(Date)
#             field_value.to_datetime.iso8601
#           when field_value.is_a?(Time)
#             field_value.iso8601
#           when field_value.is_a?(Array)
#             # sniff the first element of the array; if an int or string then assume internalId
#             # and create record refs pointing to the given IDs

#             if !field_value.empty? && (field_value.first.is_a?(String) || field_value.first.kind_of?(Integer))
#               field_value.map do |v|
#                 NetSuite::Records::NullRecordRef.new(internal_id: v)
#               end
#             else
#               field_value
#             end
#           else
#             field_value
#           end

#           name = Name.new(
#             reference_id_type => reference_id,
#             :value => name_value,
#             :type  => "#{record_namespace}:#{field_type}"
#           )

#           names << name
#           @names_assoc[reference_id.to_sym] = name
#         end
#     end
#   end
# end
