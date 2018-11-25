class EventAPI < Grape::API
  # Get EventAPI
  class Get < Grape::API
    params do
      optional :title, type: String, documentation: { param_type: 'query' }
      optional :id, type: Integer, documentation: { param_type: 'query' }
    end

    get do
      events = if params[:title] || params[:id]
                 [Event[id: params[:id]] || Event[title: params[:title]]].compact
               else
                 Event.all
               end

      if events.empty?
        status 404
        return { body: 'Not found' }
      end

      { body: { objects: events.map(&:to_h) } }
    end
  end
end
