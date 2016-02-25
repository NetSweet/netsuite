module NetSuite
  module Support
    module Actions

      attr_accessor :errors

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
          when :attach_file
            self.send(:include, NetSuite::Actions::AttachFile::Support)
          when :get
            self.send(:include, NetSuite::Actions::Get::Support)
          when :get_all
            self.send(:include, NetSuite::Actions::GetAll::Support)
          when :get_deleted
            self.send(:include, NetSuite::Actions::GetDeleted::Support)
          when :get_list
            self.send(:include, NetSuite::Actions::GetList::Support)
          when :get_select_value
            self.send(:include, NetSuite::Actions::GetSelectValue::Support)
          when :search
            self.send(:include, NetSuite::Actions::Search::Support)
          when :add
            self.send(:include, NetSuite::Actions::Add::Support)
          when :upsert
            self.send(:include, NetSuite::Actions::Upsert::Support)
          when :upsert_list
            self.send(:include, NetSuite::Actions::UpsertList::Support)
          when :delete
            self.send(:include, NetSuite::Actions::Delete::Support)
          when :delete_list
            self.send(:include, NetSuite::Actions::DeleteList::Support)
          when :update
            self.send(:include, NetSuite::Actions::Update::Support)
          when :update_list
            self.send(:include, NetSuite::Actions::UpdateList::Support)
          when :initialize
            self.send(:include, NetSuite::Actions::Initialize::Support)
          else
            raise "Unknown action: #{name.inspect}"
          end
        end

      end

    end
  end
end
