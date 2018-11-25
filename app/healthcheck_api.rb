# healthcheck endpoint
class HealthcheckApi < Grape::API
  format :json

  version 'v1', using: :path

  desc 'healthcheck', summary: 'healthcheck endpoint',
                      tags:    ['healthcheck']
  get '/ping' do
    { ping: 'pong' }
  end
end
