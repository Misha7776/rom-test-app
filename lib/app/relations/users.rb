# frozen_string_literal: true

module App
  module Relations
    class Users < ROM::Relation[:sql]
      schema(:users, infer: true) do
        associations do
          has_many :posts
        end
      end
    end
  end
end
