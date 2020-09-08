class Proxy
  def initialize(legacy, fancy, collector)
    @legacy = legacy
    @fancy = fancy
    @collector = collector
  end

  def handle(request)
    legacy_response = nil
    legacy_thread = Thread.new do
      legacy_response = @legacy.handle(request)
    end

    fancy_response = nil
    fancy_thread = Thread.new do
      fancy_response = @fancy.handle(request)
    end

    legacy_thread.join
    fancy_thread.join

    @collector.track(request, legacy_response, fancy_response)

    legacy_response
  end
end
