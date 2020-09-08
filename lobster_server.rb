require 'socket'
require 'rack'
require 'rack/lobster'

app = Rack::Lobster.new
server = TCPServer.new 3001

loop do
  Thread.start(server.accept) do |session|
    request = session.gets.strip
    verb, full_path = request.split(' ')
    path, query = full_path.split('?')

    status, headers, body = app.call({
      'REQUEST_METHOD' => verb,
      'PATH_INFO' => path,
      'QUERY_STRING' => query
    })

    session.print("HTTP/1.1 #{status}\r\n")
    headers.each do |key, value|
      session.print("#{key}: #{value}\r\n")
    end
    session.print("\r\n")
    body.each do |part|
      session.print(part)
    end
  rescue
    puts "ERROR!!!"
  ensure
    session.close
  end
end
