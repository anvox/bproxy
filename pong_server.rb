require 'socket'

# curl --verbose 127.0.0.1:20000 -> 404
# curl --verbose 127.0.0.1:20000/ping -> pong 200

dts = TCPServer.new('127.0.0.1', 20000)
loop do
  Thread.start(dts.accept) do |client|
    print(client, " is accepted\n")
    request = client.gets.strip
    if request == 'GET /ping HTTP/1.1'
      client.print("HTTP/1.1 200\r\n")
      client.print("Content-Type: text/html\r\n")
      client.print("pong\r\n")
    else
      client.print("HTTP/1.1 404\r\n")
    end
    print(client, " is gone\n")
    client.close
  end
end
