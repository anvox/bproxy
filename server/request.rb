class Request
  def initialize
    @http_method = nil
    @path = nil
    @headers = {}
    @body = nil
  end

  def request_line(string)
    @http_method, @path, _ = string.split(' ')
  end

  def header_line(string)
    header_name, value = string.split(' ')
    header_name = header_name.chop

    headers[header_name.upcase] = value
  end

  def content_length
    headers['CONTENT-LENGTH'].to_i
  end

  def data_lines(string)
    @body = string
  end

  attr_reader :http_method,
              :path,
              :headers,
              :body
end
