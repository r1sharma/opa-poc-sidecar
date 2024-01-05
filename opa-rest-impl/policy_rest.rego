package httpapi.authz

import rego.v1

# bob is alice's manager, and betty is charlie's.
subordinates := {"alice": [], "charlie": [], "bob": ["alice"], "betty": ["charlie"]}

default allow := false

# Allow users to get their own salaries.
allow if {
	input.method == "GET"
	input.path == ["finance", "salary", input.user]
}

# Allow managers to get their subordinates' salaries.
allow if {
	some username
	input.method == "GET"
	input.path = ["finance", "salary", username]
	subordinates[input.user][_] == username
}