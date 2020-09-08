class Distributor
  def initialize(legacy, fancy)
    @legacy = legacy
    @fancy = fancy
  end

  def dispatch(request)
    if Collector.met?(request.key)
      dispatch_to_fancy(request)
    else
      dispatch_both(request)
    end
  end

  private

  def dispatch_to_fancy(request)
    fancy_response = @fancy.handle(request)
    if fancy_response.status < 400
      # TODO: [AV] Use NullObject
      DistributedResponse.new(nil,
                              fancy_response)
    else
      DistributedResponse.new(@legacy.handle(request),
                              # TODO: [AV] Use NullObject
                              nil)
    end
  end

  def dispatch_both(request)
    DistributedResponse.new(@legacy.handle(request),
                            @fancy.handle(request))
  end
end
