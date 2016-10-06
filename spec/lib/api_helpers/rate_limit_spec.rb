require './lib/api_helpers/rate_limit'
require 'rails_helper'

describe RateLimit do
  let(:url) { '/api/home/index' }
  let(:sender) { '123.0.0.1' }
  let(:limit) { Settings.api_rate_limit.limit }
  let(:interval) { Settings.api_rate_limit.interval }
  let(:rate_limiter) { RateLimit.new(url, sender) }

  describe '#rate_limiter' do
    it 'responds to add_sender' do
      expect(rate_limiter).to respond_to(:add_sender)
    end
  end

  describe '#add_sender' do
    context 'when the sender does exist' do
      let(:sender) { FFaker::Internet.ip_v4_address }

      it 'adds sender' do
        expect(rate_limiter.add_sender).to eq([1, "OK", true])
      end
    end

    context 'when the sender exists' do
      let(:sender) { FFaker::Internet.ip_v4_address }

      before do
        rate_limiter.add_sender
      end

      it 'adds sender' do
        expect(rate_limiter.add_sender).to eq([2, "OK", true])
      end
    end
  end

  describe '#retry_in' do
    context 'when the limit has been exceeded' do
      let(:sender) { FFaker::Internet.ip_v4_address }

      before do
        limit.times do
          rate_limiter.add_sender
        end
      end

      it 'returns time' do
        expect(rate_limiter.retry_in.round).to eq(interval)
      end
    end
  end

  describe '#check_limit' do
    context 'when the limit has been exceeded' do
      let(:sender) { FFaker::Internet.ip_v4_address }

      before do
        limit.times do
          rate_limiter.add_sender
        end
      end

      it 'returns time' do
        expect(rate_limiter.check_limit).to eq("Rate limit exceeded. Try again in #{interval} seconds")
      end
    end

    context 'when the limit has not been exceeded' do
      let(:sender) { FFaker::Internet.ip_v4_address }

      before do
        (limit-1).times do
          rate_limiter.add_sender
        end
      end

      it 'returns time' do
        expect(rate_limiter.check_limit).to eq(nil)
      end
    end
  end
end
