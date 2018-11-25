class EventAPI < Grape::API
  # Get EventAPI by filter or by id
  class Create < Grape::API
    desc 'Create event'
    params do
      requires :title, type: String, documentation: { param_type: 'body' }
      requires :start_time, type: Integer, documentation: { param_type: 'body' }
      requires :end_time, type: Integer, documentation: { param_type: 'body' }
    end

    post do
      last_event = Event.order(Sequel.asc(:end_time)).limit(1).last

      unless params[:start_time] < params[:end_time]
        status 400
        return { body: 'start_time must be less then end_time' }
      end

      if last_event && params[:start_time] < last_event[:end_time]
        status 409
        return { body: 'Already exists' }
      end

      event = Event.create(params.slice(:title, :start_time, :end_time))

      { body: { object: event.to_h } }
    end
  end
end
