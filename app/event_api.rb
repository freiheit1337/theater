require 'get'
require 'get_now'
require 'create'

# Just Event API
class EventAPI < Grape::API
  format :json
  version 'v1', using: :path

  resource :event do
    mount EventAPI::Create
    mount EventAPI::Get
    # mount EventAPI::Update
    # mount EventAPI::Delete
  end
end
