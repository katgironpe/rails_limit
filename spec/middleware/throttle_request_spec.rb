require 'rails_helper'

describe ThrottleRequest do
  let(:app) { proc{ [200, {}, ['OK']] } }
  let(:middleware) { ThrottleRequest.new(app) }

  context 'when GET / is called once' do
    let(:req) { Rack::MockRequest.new(middleware) }
    let(:response) { req.get('/', 'REMOTE_ADDR' => FFaker::Internet.ip_v4_address) }

    it 'returns the correct response status and body' do
      expect(response.status).to eq(200)
      expect(response.body).to eq('OK')
    end
  end
end
