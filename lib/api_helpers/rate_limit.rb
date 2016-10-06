require 'redis'
require 'redis_rate_limiter'

class RateLimit
  def initialize(url, sender)
    @url = url
    @sender = sender
    rate_limiter
  end

  def rate_limiter
    redis = Redis.new
    rl ||= RedisRateLimiter.new(@url, redis, limit: Settings.api_rate_limit.limit, interval: Settings.api_rate_limit.interval)
  end

  def add_sender
    rate_limiter.add(@sender)
  end

  def retry_in
    rate_limiter.retry_in?(@sender)
  end

  def check_limit
    if rate_limiter.exceeded?(@sender)
      "Rate limit exceeded. Try again in #{retry_in.ceil} seconds"
    end
  end
end
