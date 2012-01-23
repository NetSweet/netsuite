module NetSuite
  module Support
    module Actions

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def actions(*args)
          instance_module = Module.new
          class_module    = Module.new
          args.each do |action|
            define_action(instance_module, class_module, action)
          end
          self.send(:include, instance_module)
          self.send(:extend, class_module)
        end

        def define_action(instance_module, class_module, action)
          case action
          when :get
            define_get(class_module)
          when :add
            define_add(instance_module)
          when :initialize
            define_initialize(class_module)
          else
            raise "Unknown action: #{action.inspect}"
          end
        end

        def define_get(class_module)
          class_module.module_eval do
            define_method :get do |*args|
              options, *ignored = *args
              response = NetSuite::Actions::Get.call(self, options)
              if response.success?
               new(response.body)
              else
               raise RecordNotFound, "#{self} with OPTIONS=#{options.inspect} could not be found"
              end
            end
          end
        end

        def define_add(instance_module)
          instance_module.module_eval do
            define_method :add do
              response = NetSuite::Actions::Add.call(self)
              response.success?
            end
          end
        end

        def define_initialize(class_module)
          (class << self; self; end).instance_eval do
            define_method :initialize do |*args|
              super(*args)
            end
          end

          class_module.module_eval do
            define_method :initialize do |object|
              response = NetSuite::Actions::Initialize.call(self, object)
              if response.success?
                new(response.body)
              else
                raise InitializationError, "#{self}.initialize with #{object} failed."
              end
            end
          end
        end

      end

    end
  end
end
