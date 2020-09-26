# frozen_string_literal: true

RomTestApp::Application.boot(:web) do |_app|
  init do
    require 'hanami-router'
    require 'hanami-controller'
    require 'warden'
    require 'bcrypt'
    require 'jwt'
  end
end
