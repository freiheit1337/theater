root = Dir.getwd.to_s

$LOAD_PATH.unshift "#{root}/app/"
$LOAD_PATH.unshift root

task :environment do
  require_relative 'app/application'
end

Dir.glob('./rakelib/**/*.rake').each { |r| import r }
