require 'rspec'

ENV['RACK_ENV'] = 'test'

root = Dir.getwd.to_s

$LOAD_PATH.unshift "#{root}/app/"
$LOAD_PATH.unshift root

require 'base'
require 'pp'

require 'rack/test'
Dir['./spec/helpers/*.rb'].each { |f| require f }

App.logger.level = :info

module RSpecHelpers
  module App
    def app
      Base
    end
  end
end

RSpec.configure do |config|
  include RSpecHelpers::DB
  include RSpecHelpers::Routes
  include RSpecHelpers::App

  include Rack::Test::Methods

  config.color = true
  config.formatter = :documentation
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
  _original_stderr = $stderr
  _original_stdout = $stdout

  config.before(:all) do
    db_truncate_tables
  end

  config.before(:each) do
    db_delete_all_records
  end
end
