class Proxy
  def initialize
    @legacy = Legacy.new
  end

  def handle(request)
    @legacy.handle(request)
  end
end
