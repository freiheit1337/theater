require 'sequel'
require 'application'

Sequel.extension :migration

# Disable warnings
Sequel.respond_to?(:split_symbols=) && Sequel.split_symbols = true
Sequel::Model.require_valid_table = false
klass = Sequel::Deprecation
def klass.deprecate(*_args); end

DBDIR = File.expand_path('../../db', __FILE__)

begin
  APIDB = Sequel.connect(App.config[:db], reconnect: true)
rescue Sequel::DatabaseError => e
  App.logger.error(exception: e, payload: { msg: 'Can\'t connect to database', db: App.config[:db] })
  exit 1
end

Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :after_initialize
Sequel::Model.plugin :timestamps

begin
  Dir['./models/*.rb'].each { |f| require f }
rescue Sequel::DatabaseError => e
  App.logger.error(exception: e, payload: { msg: 'Can\'t connect to database', db: App.config[:db] })
  exit 1
end
