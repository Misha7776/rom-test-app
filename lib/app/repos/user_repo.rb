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

      def all
        users.to_a
      end

      def by_email(email)
        users.where(email: email).as(:entity).one
      end

      def find(id)
        users.by_pk(id).as(:entity).one
      end
    end
  end
end
