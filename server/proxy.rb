class Proxy
  def self.handle(request)
    Legacy.handle(request)
  end
end
