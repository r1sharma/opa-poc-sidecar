# policy.rego
package poc.authz

import rego.v1

import input.attributes.request.http as http_request

allow if {
	is_token_valid
	action_allowed
}

is_token_valid if {
	token.valid
	now := time.now_ns() / 1000000000
	token.payload.nbf <= now
	now < token.payload.exp
}

action_allowed if {
	http_request.method == "GET"
	token.payload.role == "guest"
	glob.match("/people", ["/"], http_request.path)
}

action_allowed if {
	http_request.method == "GET"
	token.payload.role == "admin"
	glob.match("/people", ["/"], http_request.path)
}

action_allowed if {
	http_request.method == "POST"
	token.payload.role == "admin"
	glob.match("/people", ["/"], http_request.path)
	lower(input.parsed_body.firstname) != base64url.decode(token.payload.sub)
}

token := {"valid": valid, "payload": payload} if {
	[_, encoded] := split(http_request.headers.authorization, " ")
	[valid, _, payload] := io.jwt.decode_verify(encoded, {"secret": "secret"})
}