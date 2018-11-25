root = Dir.getwd.to_s

$LOAD_PATH.unshift "#{root}/app/"
$LOAD_PATH.unshift root

require 'rack/cors'

require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require 'base'

use Rack::Cors do
  allow do
    origins  '*'
    resource '*', headers: :any, methods: %i[get post put delete options]
  end
end

use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Base.new
