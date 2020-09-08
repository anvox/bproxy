class Response
  def initialize(status, headers, body)
    @status = status
    @headers = headers
    @body = body
  end

  attr_reader :status,
              :headers,
              :body

  def to_s
    "HTTP/1.1 #{status}\r\n" +
    "\r\n" +
    body
  end
end
