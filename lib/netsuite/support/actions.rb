module NetSuite
  module Support
    module Actions

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def actions(*args)
          args.each do |action|
            action(action)
          end
        end

        def action(name)
          case name
          when :get
            self.extend(NetSuite::Actions::Get::Support)
          when :add
            self.send(:include, NetSuite::Actions::Add::Support)
          when :delete
            self.send(:include, NetSuite::Actions::Delete::Support)
          when :update
            self.send(:include, NetSuite::Actions::Update::Support)
          when :initialize
            (class << self; self; end).instance_eval do # We have to do this because Class has a private
              define_method :initialize do |*args|      # #initialize method that this method will override.
                super(*args)
              end
            end
            self.extend(NetSuite::Actions::Initialize::Support)
          else
            raise "Unknown action: #{name.inspect}"
          end
        end

      end

    end
  end
end
