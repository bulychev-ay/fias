$LOAD_PATH << '.' unless $LOAD_PATH.include?('.')

require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'webmock/rspec'
require 'active_record'

SimpleCov.start do
  add_filter 'spec'
end

require 'fias/import'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
