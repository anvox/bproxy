require "excon"

class Legacy
  def initialize
    @connection = Excon.new("http://localhost:3001")
  end

  def handle(request)
    before_request = Time.now
    response = @connection.request(method: request.http_method.downcase.to_sym,
                                   path: request.path,
                                   body: request.body)
    after_request = Time.now
    Response.new(response.status, response.headers, response.body, after_request - before_request)
  rescue Excon::Error::Socket => ex
    nil
  end
end
