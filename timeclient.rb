require 'socket'

stream_sock = TCPSocket.new('127.0.0.1', 20000)
str = stream_sock.recv(100)
print str
stream_sock.close
