class Verifier
  def initialize
    @compare_data = {}
  end

  def track(request, legacy_response, fancy_response)
    if matched?(legacy_response, fancy_response)
      track_matched(request)
    else
      track_unmatched(request)
    end
  end

  private

  def matched?(legacy_response, fancy_response)
    return false if legacy_response.status != fancy_response.status
    return false if legacy_response.body.to_s != fancy_response.body.to_s
    return false if legacy_response.headers != fancy_response.headers
    return false if legacy_response.request_time < fancy_response.request_time

    true
  end

  def track_matched(request)
  end

  def track_unmatched(request)
  end
end
