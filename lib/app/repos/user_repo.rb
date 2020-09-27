# frozen_string_literal: true

module App
  module Repos
    class UserRepo < ROM::Repository[:users]
      include RomTestApp::Import['container']
      struct_namespace App

      commands :create, use: :timestamps, plugins_options: {
        timestamps: {
          timestamps: %i[created_at updated_at]
        }
      }

      commands :update, use: :timestamps, plugins_options: {
        timestamps: {
          timestamps: %i[updated_at]
        }
      }

      commands :delete

      def all
        users.to_a
      end

      def find(id)
        users.by_pk(id).as(:entity).one
      end

      def respond_to_missing?(name, include_private); end

      def method_missing(method, *args, &block)
        return super method, *args, &block unless method.to_s =~ /^find\w+/

        self.class.send(:define_method, method) do |*keys|
          users.where(keys[0]).as(:entity).one
        end

        send method, *args, &block
      end
    end
  end
end
