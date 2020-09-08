class Proxy
  def initialize(distributor, verify_class)
    @distributor = distributor
    @verify_class = verify_class
  end

  attr_reader :distributor,
              :verify_class

  def handle(request)
    distributed_response = distributor.dispatch(request)
    verifier = verify_class.new(request)

    verifier.verify(distributed_response.legacy_response,
                    distributed_response.fancy_response)

    distributed_response.response
  end
end
