namespace :db do
  desc 'Migrate database'
  task :migrate, [:version] do |_task, args|
    require 'lib/db'

    version = args[:version] ? args[:version].to_i : nil
    Sequel::Migrator.apply(APIDB, DBDIR, version)

    ObjectSpace.each_object(Class) do |klass|
      next unless klass < Sequel::Model
      klass.instance_eval { get_db_schema(true) }
    end
  end
end
