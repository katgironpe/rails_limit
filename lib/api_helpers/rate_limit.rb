require 'redis'
require 'redis_rate_limiter'

class RateLimit
  def initialize(url, sender)
    @url = url
    @sender = sender
    rate_limiter
  end

  # Configure the API rate limit and interval on config/settings/#{n}.yml where n is the environment name
  # Configure Redis port, db and host on dotenv file
  def rate_limiter
    redis = Redis.new(host: Settings.redis_host, port: Settings.redis_port, db: Settings.redis_db)
    rl ||= RedisRateLimiter.new(@url, redis, limit: Settings.api_rate_limit.limit, interval: Settings.api_rate_limit.interval)
  end

  def add_sender
    rate_limiter.add(@sender)
  end

  def retry_in
    rate_limiter.retry_in?(@sender)
  end

  # Use check_limit_exceeded to return a message if limit is exceeded
  def check_limit_exceeded
    if rate_limiter.exceeded?(@sender)
      "Rate limit exceeded. Try again in #{retry_in.ceil} seconds"
    end
  end
end
