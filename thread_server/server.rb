require 'socket'

server = TCPServer.new('localhost', 9090)

loop do
  client = server.accept

  Thread.new do
    while buffer = client.gets
      client.print(buffer)
    end

    client
  end
end
