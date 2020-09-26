# frozen_string_literal: true

module App
  module Repos
    class PostRepo < ROM::Repository[:posts]
      include RomTestApp::Import['container']
      struct_namespace App

      commands :create, use: :timestamps, plugins_options: {
        timestamps: {
          timestamps: %i[created_at updated_at]
        }
      }

      def all
        posts.to_a
      end
    end
  end
end
