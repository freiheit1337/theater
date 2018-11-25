class EventAPI < Grape::API
  # Get EventAPI
  class Get < Grape::API
    get '/now' do
      now   = Time.now.to_i
      cond  = [Sequel.lit('(start_time < ? AND end_time > ?)', now, now)]
      event = Event.where(Sequel.|(*cond)).limit(1).last

      unless event
        status 404
        return { body: 'Not found' }
      end

      { body: { object: event.to_h } }
    end
  end
end
