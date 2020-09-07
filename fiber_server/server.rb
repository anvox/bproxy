require 'socket'
require 'fiber'

class Reactor
  def initialize
    @readable = {}
    @writable = {}
  end

  def run
    puts "=1 #{Fiber.current}"
    while @readable.any? || @writable.any?
      puts "=2 #{Fiber.current}"
      readable, writable = IO.select(@readable.keys, @writable.keys, [])
      puts "=3 #{Fiber.current}"
      readable.each do |io|
        @readable[io].resume
      end
      writable.each do |io|
        @writable[io].resume
      end
    end
  end

  def wait_readable(io)
    @readable[io] = Fiber.current
    Fiber.yield
    @readable.delete(io)

    return yield if block_given?
  end

  def wait_writable(io)
    @writable[io] = Fiber.current
    Fiber.yield
    @writable.delete(io)

    return yield if block_given?
  end
end

server = TCPServer.new('localhost', 9090)
reactor = Reactor.new

Fiber.new do
  puts "#{Time.now.to_i} ==1: #{Fiber.current}"
  loop do
    client = reactor.wait_readable(server) { server.accept }

    Fiber.new do
      puts "#{Time.now.to_i} ==2: #{Fiber.current}"
      buffer = reactor.wait_readable(client) { client.gets }

      http_method, path = buffer.split
      headers = {}
      while buffer = reactor.wait_readable(client) { puts "#{Time.now.to_i} ==2:1: #{Fiber.current} - #{buffer}"; client.gets.strip }
        break if buffer == ""

        buffer = buffer.split(' ')
        headers[buffer[0].chop] = buffer[1].strip
      end

      if headers["Content-Length"].to_i > 0
        data = reactor.wait_readable(client) { puts "#{Time.now.to_i} ==3:2: #{Fiber.current}"; client.read(headers["Content-Length"].to_i) }
      end

      client.close
      puts "#{Time.now.to_i} ==4:1: #{Fiber.current} - CLOSED"
    end.resume
  end
end.resume

reactor.run
