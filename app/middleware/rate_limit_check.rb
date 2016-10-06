require './lib/api_helpers/rate_limit'

class RateLimitCheck
  def initialize(app, options = {})
    @app = app
    @path = options[:path] || "/"
  end

  def call(env)
    @status, @headers, @response = @app.call(env)

    rate_limit_check = RateLimit.new(env['REMOTE_ADDR'], env['ORIGINAL_FULLPATH'])
    rate_limit_check.add_sender

    if rate_limit_check.check_limit
      [429, {'Content-Type' => 'text/plain'}, rate_limit_check.check_limit]
    else
      [@status, @headers, @response]
    end
  end
end
