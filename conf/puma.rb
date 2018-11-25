root = Dir.getwd.to_s

rackup "#{root}/config.ru"
daemonize false

threads 0, 16

bind 'tcp://0.0.0.0:9760'

preload_app!
