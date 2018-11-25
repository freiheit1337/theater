require 'spec_helper'

describe EventAPI::Create do
  let(:handler) { '/v1/event' }

  context 'when not found' do
    before(:each) do
      Event.create title: 'theatricals1', start_time: (Time.now - 6.days).to_i, end_time: (Time.now - 4.days).to_i
      Event.create title: 'theatricals2', start_time: (Time.now - 2.days).to_i, end_time: Time.now.to_i
    end

    it 'should return 201' do
      post handler, title: 'theatricals3', start_time: (Time.now + 2.days).to_i, end_time: (Time.now + 4.days).to_i
      expect_201
    end

    it 'should create event' do
      post handler, title: 'theatricals4', start_time: (Time.now + 6.days).to_i, end_time: (Time.now + 8.days).to_i
      expect(last_json['object']['title']).to eq 'theatricals4'
    end

    it do
      post handler, title: 'theatricals3', end_time: Time.now.to_i
      expect_400
    end

    it do
      post handler, title: 'theatricals3', end_time: Time.now.to_i
      expect(last_json).to eq [{ 'params' => ['start_time'], 'messages' => ['is missing'] }]
    end

    it do
      post handler, title: 'theatricals3', start_time: (Time.now - 2.days).to_i, end_time: (Time.now - 3.days).to_i
      expect_400
    end

    it do
      post handler, title: 'theatricals3', start_time: (Time.now - 2.days).to_i, end_time: (Time.now - 3.days).to_i
      expect(last_json).to eq 'start_time must be less then end_time'
    end

    it 'when found' do
      post handler, title: 'theatricals2', start_time: (Time.now - 2.days).to_i, end_time: Time.now.to_i
      expect_409
    end
  end
end
