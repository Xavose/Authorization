package northstar

 

import future.keywords.if
import future.keywords.in
import data.dashboard
 

default allow := false

 

#allowed_actions := data.dashbaord.user_resources[input.realm][input.user].actions

 

# Allow some paths by default:
allow if {
    default_allowed_paths
}

 

default_allowed_paths if {
    some path
    startswith(input.path, data.dashbaord.allowed_paths[path])
}

 

# Dynamically determine the resource and permission:
allow if {
    requested_resource == data.dashbaord.user_resources[input.realm][input.user].resource
    requested_operation == data.dashbaord.user_resources[input.realm][input.user].actions[_]
}

 

requested_resource = result if {
    some resource, operation
    input.path == data.dashbaord.resource_paths[resource][operation][_]
    result = resource
}

 

requested_operation = result if {
    some resource, operation
    input.path == data.dashbaord.resource_paths[resource][operation][_]
    result = operation
}
