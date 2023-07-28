package dashboard

import future.keywords.if
import future.keywords.in
# import data.dashboard

default allow := false

allowed_actions := data.user_resources[input.realm][input.user].actions

# Allow some paths by default:
allow {
    default_allowed_paths
}

default_allowed_paths {
    some path
    startswith(input.path, data.allowed_paths[path])
}

# Dynamically determine the resource and permission:
allow {
    requested_resource == data.user_resources[input.realm][input.user].resource[_]
    requested_operation == data.user_resources[input.realm][input.user].actions[_]
}

requested_resource = result {
    some resource, operation
    input.path == data.resource_paths[resource][operation][_]
    result = resource
}

requested_operation = result {
    some resource, operation
    input.path == data.resource_paths[resource][operation][_]
    result = operation
}
