package dashboard

import future.keywords.if
import future.keywords.in
# import data.dashboard

default allow := false

allowed_actions := data.dashboard.user_resources[input.realm][input.user].actions

# Allow some paths by default:
allow {
    default_allowed_paths
}

default_allowed_paths {
    some path
    startswith(input.path, data.dashboard.allowed_paths[path])
}

# Dynamically determine the resource and permission:
allow {
    requested_resource == data.dashboard.user_resources[input.realm][input.user].resource
    requested_operation == data.dashboard.user_resources[input.realm][input.user].actions[_]
}

requested_resource = result {
    some resource, operation
    input.path == data.dashboard.resource_paths[resource][operation][_]
    result = resource
}

requested_operation = result {
    some resource, operation
    input.path == data.dashboard.resource_paths[resource][operation][_]
    result = operation
}
