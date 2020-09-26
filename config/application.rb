# frozen_string_literal: true

require_relative 'boot'
require_relative 'initializers/warden'

require 'dry/system/container'
require 'dry/auto_inject'
require 'pry'

module RomTestApp
  class Application < Dry::System::Container
    configure do |config|
      config.root = File.expand_path('..', __dir__)
      config.default_namespace = 'app'
      config.name = :rom_test_app
      config.auto_register = 'lib'
    end

    load_paths!('lib')
  end

  Import = Dry::AutoInject(Application)
end
