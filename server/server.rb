require_relative './request'
require_relative './response'

require_relative './legacy'
require_relative './fancy'
require_relative './proxy'
require_relative './verifier'

require 'socket'

class BProxy
  def initialize(port = 3000)
    @server = TCPServer.new('localhost', port)
    @distributor = Distributor.new(Legacy.new, Fancy.new)
    @verifier_class = Verifier
  end

  def start
    loop do
      client = server.accept

      Thread.new do
        request = Request.new

        request.request_line(client.gets)

        while buffer = client.gets
          break if buffer.strip == ""

          request.header_line(buffer)
        end

        data = client.read(request.content_length)
        request.data_lines(data)

        response = Proxy.new(@distributor, @verifier_class).handle(request)

        client.write(response.to_s)
      rescue StandardError => ex
        puts ex
        puts "ERROR !!!"
      ensure
        client.close
      end
    end
  end

  private

  attr_reader :server
end
