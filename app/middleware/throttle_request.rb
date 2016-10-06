require './lib/api_helpers/rate_limit'

class ThrottleRequest
  def initialize(app)
    @app = app
  end

  # This middleware works for all requests
  # If the user has accessed the rate-limited API URL beyond the limit,
  # return 429 status with a message
  def call(env)
    status, headers, response = @app.call(env)

    rate_limit_check = RateLimit.new(env['REMOTE_ADDR'], env['ORIGINAL_FULLPATH'])
    rate_limit_check.add_sender

    rate_limit_exceeded = rate_limit_check.check_limit_exceeded

    if rate_limit_exceeded
      [429, {'Content-Type' => 'text/plain'}, rate_limit_exceeded]
    else
      [status, headers, response]
    end
  end
end
