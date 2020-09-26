# frozen_string_literal: true

require_relative 'config/application'

RomTestApp::Application.finalize!

run App::Web.app
