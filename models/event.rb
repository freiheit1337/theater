# Event
class Event < Sequel::Model(:events)
  def before_create
    @values[:start_time] ||= Time.now.to_i
    @values[:end_time]   ||= (Time.now + 1.month).to_i
  end

  def to_h
    {
      start_time: Time.at(start_time),
      end_time:   Time.at(end_time),
      title:      title
    }
  end
end
