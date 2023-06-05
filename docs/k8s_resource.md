# K8S Resource

## Schema Properties

|                                       | Type                                     | Description                                                                                                                                                                    | Required   |
|:--------------------------------------|:-----------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|
| kind                                  | enum: k8s_resource                       |                                                                                                                                                                                | Yes        |
| flavor                                | enum: default                            |                                                                                                                                                                                | Yes        |
| version                               | enum: 0.1, latest                        |                                                                                                                                                                                | Yes        |
| lifecycle                             | enum: ENVIRONMENT, ENVIRONMENT_BOOTSTRAP | This field describes the phase in which the resource has to be invoked (`ENVIRONMENT` or `ENVIRONMENT_BOOTSTRAP`)                                                              | No         |
| disabled                              | boolean                                  | Flag to disable the resource                                                                                                                                                   | No         |
| conditional_on_intent                 | string                                   | Flag to enable the resource based on intent availability. eg mysql if mysql dashboard is required to be deployed. Note: Need to have the instance running beforehand to avail. | No         |
| provided                              | boolean                                  | Flag to tell if the resource should not be provisioned by facets                                                                                                               | No         |
| depends_on                            | array                                    | Dependencies on other resources. e.g. application x may depend on mysql                                                                                                        | No         |
| metadata.name                         | string                                   | Name of the resource                                                                                                                                                           | No         |
|                                       |                                          |     - if not specified, fallback is the `filename`                                                                                                                             |            |
| spec                                  | object                                   | Specification as per resource types schema                                                                                                                                     | Yes        |
| advanced                              | object                                   | Additional fields if any for a particular implementation of a resource                                                                                                         | No         |
| advanced.k8s_resource.timeout         | integer                                  | Timeout for the resource                                                                                                                                                       | No         |
| advanced.k8s_resource.cleanup_on_fail | boolean                                  | Whether to clean up when the resource installation fails                                                                                                                       | No         |
| advanced.k8s_resource.wait            | boolean                                  | Whether to wait until all the resources has been successfully created                                                                                                          | No         |
| spec.resource                         | object                                   | This should contain the kubernetes YAML manifest converted to JSON and pasted in a block                                                                                       | No         |

## Outputs

|                                                                     | Type   | Description                                       | Required   | Referencing                                                                                       |
|:--------------------------------------------------------------------|:-------|:--------------------------------------------------|:-----------|:--------------------------------------------------------------------------------------------------|
| out                                                                 | object | Output given by the resource for others to refer. | No         | ${k8s_resource.RESOURCE_NAME.out}                                                                 |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.username          | string | Username to connect (if any)                      | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.username}          |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.password          | string | Password to connect (if any)                      | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.password}          |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.host              | string | Host for service discovery                        | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.host}              |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.port              | string | Port for service discovery                        | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.port}              |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.name              | string | Name of interface, same as key                    | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.name}              |
| out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.connection_string | string | Connection string to connect                      | No         | ${k8s_resource.RESOURCE_NAME.out.interfaces.INTERFACE_NAME.INTERFACE_NAME_NAME.connection_string} |
