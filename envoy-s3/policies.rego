package cli

import rego.v1

default allow := false

allow if deny == set()

bucket := split(input.requested_path, "/")[1]

deny contains msg if {
	bucket == "opa-bundle-rest"
	not "demo-sa" in input.service_account
	msg := "opa-bundle-rest is only accessible other than demo-sa service account"
}

deny contains msg if {
	count(bucket) < 2
	msg := "malformed requested path, could not determine bucket"
}
