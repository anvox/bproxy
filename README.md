A proxy prototype, which measures new-endpoint and fully redirect to new after all passed.

Requirement:

* Forward to old-endpoint
* Get old result and async forward request, old-response to verifier
* Verifier get response from new-endpoint and return pass/fail to proxy
* Track pass/fail result. And depends on (dynamic) monitor conditions, change to route to new-endpoint
* Fallback to old-endpoint if new-endpoint failed
* Timeout is considered failed, and should be fallback early

Consider:

* Performance, apdex
* Response verification
* Dynamic conditions

