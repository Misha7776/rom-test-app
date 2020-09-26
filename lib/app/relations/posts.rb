# frozen_string_literal: true

module App
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts, infer: true) do
        associations do
          belongs_to :user
        end
      end
    end
  end
end
