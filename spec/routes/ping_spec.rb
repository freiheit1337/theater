require 'spec_helper'

describe HealthcheckApi do
  describe '/v1/ping' do
    let(:handler) { '/v1/ping' }

    describe 'GET' do
      it do
        get handler
        expect_200
      end
    end

    describe 'POST' do
      it do
        post handler
        expect_405
      end
    end
  end
end
