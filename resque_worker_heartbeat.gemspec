# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'resque_worker_heartbeat/version'

Gem::Specification.new do |s|
  s.name         = "resque_worker_heartbeat"
  s.version      = ResqueWorkerHeartbeat::VERSION
  s.authors      = ["Sven Fuchs", "Jon Phillips", "Andy Sykes"]
  s.email        = "developers@forward3d.com"
  s.homepage     = "https://github.com/forward3d/resque_worker_heartbeat"
  s.summary      = "Gives Resque workers a heartbeat to allow dead worker detection"
  s.description  = "Gives Resque workers a heartbeat to allow dead worker detection"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_dependency 'resque', '~> 1.25.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
