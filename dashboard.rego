# Allow some paths by default:
allow {
    default_allowed_paths
}

default_allowed_paths {
    some path
    startswith(input.path, data.allowed_paths[path])
}

# Dynamically determine the resource and permission:
# Loop over the roles in the input
allow {
    some i
    requested_resource == data.permissions[input.roles[i]].resource
    requested_action == data.permissions[input.roles[i]].actions[_]
}

requested_resource = result {
    some resource, action
    input.path == data.resource_paths[resource][action][_]
    result = resource
}

requested_action = result {
    some resource, action
    input.path == data.resource_paths[resource][action][_]
    result = action
}
