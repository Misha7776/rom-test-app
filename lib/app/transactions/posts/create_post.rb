# frozen_string_literal: true

module App
  module Transactions
    module Posts
      class CreatePost
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)
        include RomTestApp::Import['contracts.posts.create_post', 'repos.post_repo']

        def call(input)
          values = yield validate(input)
          user = yield persist(values)

          Success(user)
        end

        def validate(params)
          create_post.call(params).to_monad
        end

        def persist(result)
          Success(post_repo.create(result.values))
        end
      end
    end
  end
end
