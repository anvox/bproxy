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
  end

  def track_matched(request)
  end

  def track_unmatched(request)
  end
end
