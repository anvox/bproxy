require_relative './request'
require_relative './response'

require_relative './legacy'
require_relative './fancy'
require_relative './proxy'

require 'socket'

server = TCPServer.new('localhost', 9090)

loop do
  client = server.accept

  Thread.new do
    buffer = client.gets
    http_method, path = buffer.split(' ')

    headers = {}
    while buffer = client.gets
      header_name, header_value = buffer.split(' ')
      header_name = header_name.chop

      headers[header_name.downcase] = value
    end
    data = client.read(headers['content-length'].to_i)

    request = Request.new(http_method, path, headers, data)
    response = Proxy.hanlde(request)

    client.response(response.to_s)
  rescue StandardError

  ensure
    client.close
  end
end
