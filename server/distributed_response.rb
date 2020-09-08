class DistributedResponse
  def initialize(legacy_reseponse, fancy_response)
    @legacy_reseponse = legacy_reseponse
    @fancy_response = fancy_response
  end

  attr_reader :legacy_reseponse,
              :fancy_response
  def response
    fancy_response || legacy_reseponse
  end
end
