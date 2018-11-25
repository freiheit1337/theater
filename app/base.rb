require 'lib/db'
require 'grape'
require 'grape-swagger'

require 'models/event'

require 'application'

require 'healthcheck_api'
require 'event_api'

# disable hashie warnings
Hashie.logger = Logger.new(nil)

# Base for swagger generation
class Base < Grape::API
  format :json

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    App.logger.error(e)
    error!({ body: e }, 400)
  end

  rescue_from Grape::Exceptions::MethodNotAllowed do |e|
    App.logger.error(e)
    error!({ body: 'Method is not allowed' }, 405)
  end

  rescue_from :all do |e|
    App.logger.error(e)
    error!({ body: 'Server error' }, 500)
  end

  mount HealthcheckApi
  mount EventAPI

  add_swagger_documentation(
    hide_documentation_path: true,
    api_version: 'v1',
    schemes: ['http'],
    info: {
      title:       'Theater schedule',
      description: 'API for theater schedule management'
    }
  )
end
