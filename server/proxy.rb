class Proxy
  def self.handle(request)
    Legacy.handle(request)
    Response.new
  end
end
