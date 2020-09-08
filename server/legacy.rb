require "excon"

class Legacy
  def initialize
    @connection = Excon.new("http://localhost:3001")
  end

  def handle(request)
    response = @connection.request(method: request.http_method.downcase.to_sym,
                                   path: request.path,
                                   body: request.body)

    Response.new(response.status, response.headers, response.body)
  rescue Excon::Error::Socket => ex
    nil
  end
end
