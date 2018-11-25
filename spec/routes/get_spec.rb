require 'spec_helper'

describe EventAPI::Get do
  describe '/v1/event' do
    let(:handler) { '/v1/event' }

    context 'when found' do
      before(:each) do
        Event.create title: 'theatricals'
      end

      it 'should return 200' do
        get handler
        expect_200
      end

      it 'should return events' do
        get handler
        expect(last_json['objects'][0]['title']).to eq 'theatricals'
      end

      it 'should return 200 by title' do
        get "#{handler}?title=theatricals"
        expect_200
      end

      it 'should return events by title' do
        get "#{handler}?title=theatricals"
        expect(last_json['objects'][0]['title']).to eq 'theatricals'
      end
    end

    context 'when not found' do
      it do
        get "#{handler}?title=theatricals123"
        expect_404
      end

      it do
        get handler
        expect_404
      end
    end
  end

  describe '/v1/event/now' do
    let(:handler) { '/v1/event/now' }

    context 'when found' do
      before(:each) do
        Event.create title: 'theatricals', start_time: (Time.now - 1.days).to_i, end_time: (Time.now + 1.day).to_i
      end

      it 'should return 200' do
        get handler
        expect_200
      end

      it 'should return event' do
        get handler
        expect(last_json['object']['title']).to eq 'theatricals'
      end
    end

    context 'when not found' do
      it do
        get handler
        expect_404
      end
    end
  end
end
