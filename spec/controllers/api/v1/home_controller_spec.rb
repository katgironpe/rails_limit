require 'rails_helper'

describe Api::V1::HomeController do
  def app
    RailsLimit::Application
  end

  describe '#index' do
    let(:limit) { Settings.api_rate_limit.limit }
    let(:interval) { Settings.api_rate_limit.interval }

    context 'when the number of requests does not exceed limit' do
      it 'returns http success' do
        2.times do
          get '/api/v1/home/index', {}, 'REMOTE_ADDR' => '1.2.3.4.5'
        end

        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq('OK')
      end
    end

    context 'when the number of requests exceed limit' do
      it 'returns http success' do
        limit.times do
          get '/api/v1/home/index', {}, 'REMOTE_ADDR' => '1.2.3.4.5.6'
        end

        expect(last_response.status).to eq(429)
        expect(last_response.body).to eq("Rate limit exceeded. Try again in #{interval} seconds")
      end
    end
  end
end
