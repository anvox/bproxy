class Response
  def initialize(status, headers, body, request_time)
    @status = status
    @headers = headers
    @body = body
    @request_time = request_time
  end

  attr_reader :status,
              :headers,
              :body,
              :request_time

  def to_s
    "HTTP/1.1 #{status}\r\n" +
    "\r\n" +
    body
  end
end
