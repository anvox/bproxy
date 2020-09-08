class Verifier
  def initialize(request)
    @request = request
    @compare_data = {}
  end

  attr_reader :request

  def verify(legacy_response, fancy_response)
    if matched?(legacy_response, fancy_response)
      track_matched(request)
    else
      track_unmatched(request)
    end
  end

  private

  def matched?(legacy_response, fancy_response)
    # TODO: [AV] Make this flexible
    return false if legacy_response.status != fancy_response.status
    return false if legacy_response.body.to_s != fancy_response.body.to_s
    return false if legacy_response.headers != fancy_response.headers
    return false if legacy_response.request_time < fancy_response.request_time

    true
  end

  def track_matched(request)
    Collector.collect(request.key, true)
  end

  def track_unmatched(request)
    Collector.collect(request.key, false)
  end
end
