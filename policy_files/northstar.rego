package northstar

import future.keywords.if

default allow := false

# Allow some paths by default
allow {
    default_allowed_paths
}

default_allowed_paths {
    some path
    startswith(input.path, data.allowed_paths[path])
}

# Pattern matching for GUIDs
allow if {
	pattern := "^\/workspaces\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}.*"
	regex.match(pattern, input.path)
}


#Find resource
requested_resource = result if {
    some res, act
    input.path == data.resource_paths[res][act][_]
    result = res
}

#Find action
requested_action = result if {
    some res, act
    input.path == data.resource_paths[res][act][_]
    result = act
}

#Search requested action in permissions
allowed_resource = result if {
    some rol,res,act
    requested_action == data.permissions[rol][res][act][_]
    result = res
}

# Compare requested and allowed 
allow if {
    requested_resource == allowed_resource
    requested_action == data.permissions[input.roles[_]][requested_resource][act][_]
}