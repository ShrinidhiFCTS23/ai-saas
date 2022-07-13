# Module Schema Guidelines

## General guidelines

- All multi-word keys should be snake case.

## Terms
- **Resource**: An entity declared in facets 
- **Type of Resource** or **Intent**: A resource expressible in facets JSON representation having a defined schema
- **Implementation of Resource** or **Flavor**: A specific way of implementing a resource, for example redis can be implemented as a stateful set in kubernetes and elasticcache in AWS.
- **Blueprint**: Collection of resource to create a functional product
- **Environment**: Implementation of this blueprint.


## Basic Schema

- **kind**: Describes the type of resource
  - e.g. ingress, application, mysql etc.
  - if not specified, fallback is the `folder_name`/instances
- **flavor**: Implementation selector for the resource
  - e.g. for a resource type ingress, default, aws_alb, gcp_alb etc.
- **version**: In case of multiple versions of a resource implementation, this field can be used to pin to a particular version
  - default version is `latest`
- **lifecycle**: There are multiple phases in lifecycle of an environment launch, this field describes the phase in which the resource has to be invoked
  - `ENVIRONMENT_BOOTSTRAP`
  - `ENVIRONMENT_NORMAL` (default)
- **disabled**: Flag to disable the resource
  - boolean
- **provided**: Flag to tell if the resource should not be provisioned by facets
  - A MySQL can be provisioned outside the facets but can exist in the blueprint for other to refer the url, username etc.
  - the out _section_ has to be populated by the user
- **depends_on**: any dependencies on other resources
  - application x may depend on mysql y
  - `depends_on: ["mysql.y"]`
- **metadata**: Metadata related to the resource
  - name: Name of the resource
  - if not specified, _fallback is the `file name`_
- **spec**: Specification for the resource 
  - Specification as per resource types schema
- **out**: Output given by the resource for others to refer.
  - Outputs as per resource types schema
- **advanced**: Additional fields if any for a particular implementation of a resource, to make it more configurable along with the standard fields
