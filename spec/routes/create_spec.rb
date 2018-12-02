require 'spec_helper'

describe EventAPI::Create do
  let(:handler) { '/v1/event' }

  context 'add new' do
    before(:each) do
      # 02.04 - 10.04
      Event.create(
        title: 'three_sisters',
        start_time: DateTime.parse('2018 apr 04 00:00:00 UTC').to_i,
        end_time: DateTime.parse('2018 apr 10 23:59:59 UTC').to_i
      )
      # 18.04 - 25.04
      Event.create(
        title: 'the_wolf_and_the_seven_goats',
        start_time: DateTime.parse('2018 apr 18 00:00:00 UTC').to_i,
        end_time: DateTime.parse('2018 apr 25 23:59:59 UTC').to_i
      )
    end

    it 'should create tureen_a' do
      # а) 21.03 - 23.03
      post handler, title: 'tureen_a',
                    start_time: DateTime.parse('2018 may 21 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 may 23 23:59:59 UTC').to_i
      expect(last_json['object']['title']).to eq 'tureen_a'
    end

    it 'should not create tureen_b' do
      # б) 01.04 - 05.04
      post handler, title: 'tureen_b',
                    start_time: DateTime.parse('2018 apr 1 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 apr 5 23:59:59 UTC').to_i
      expect(last_json).to eq 'Already exists'
    end

    it 'should not create tureen_c' do
      # в) 06.04 - 09.04
      post handler, title: 'tureen_c',
                    start_time: DateTime.parse('2018 apr 6 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 apr 9 23:59:59 UTC').to_i
      expect(last_json).to eq 'Already exists'
    end

    it 'should not create tureen_d' do
      # г) 12.04 - 17.04
      post handler, title: 'tureen_d',
                    start_time: DateTime.parse('2018 apr 12 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 apr 17 23:59:59 UTC').to_i
      expect(last_json).to eq 'Already exists'
    end

    it 'should not create tureen_e' do
      # д) 23.04 - 28.04
      post handler, title: 'tureen_e',
                    start_time: DateTime.parse('2018 apr 23 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 apr 28 23:59:59 UTC').to_i
      expect(last_json).to eq 'Already exists'
    end

    it 'should create tureen_f' do
      # е) 29.04 - 30.04
      post handler, title: 'tureen_f',
                    start_time: DateTime.parse('2018 apr 29 00:00:00 UTC').to_i,
                    end_time: DateTime.parse('2018 apr 30 23:59:59 UTC').to_i
      expect(last_json['object']['title']).to eq 'tureen_f'
    end
  end

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
