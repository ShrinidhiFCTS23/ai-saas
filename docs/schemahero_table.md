# Schemahero Table

## Schema Properties

|                                             | Type                                     | Description                                                                                                                                                                    | Required   |
|:--------------------------------------------|:-----------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|
| kind                                        | string                                   | Describes the type of resource. e.g. ingress, application, mysql etc. If not specified, fallback is the `folder_name`/instances                                                | Yes        |
| flavor                                      | enum: default                            | Implementation selector for the resource. e.g. for a resource type ingress, default, aws_alb, gcp_alb etc.                                                                     | Yes        |
| version                                     | enum: 0.1                                | This field can be used to pin to a particular version                                                                                                                          | Yes        |
| lifecycle                                   | enum: ENVIRONMENT, ENVIRONMENT_BOOTSTRAP | This field describes the phase in which the resource has to be invoked (`ENVIRONMENT` or `ENVIRONMENT_BOOTSTRAP`)                                                              | No         |
| disabled                                    | boolean                                  | Flag to disable the resource                                                                                                                                                   | No         |
| conditional_on_intent                       | string                                   | Flag to enable the resource based on intent availability. eg mysql if mysql dashboard is required to be deployed. Note: Need to have the instance running beforehand to avail. | No         |
| provided                                    | boolean                                  | Flag to tell if the resource should not be provisioned by facets                                                                                                               | No         |
| depends_on                                  | array                                    | Dependencies on other resources. e.g. application x may depend on mysql                                                                                                        | No         |
| metadata.name                               | string                                   | Name of the resource                                                                                                                                                           | No         |
| spec                                        | object                                   | Specification as per resource types schema                                                                                                                                     | Yes        |
| advanced                                    | object                                   | Additional fields if any for a particular implementation of a resource                                                                                                         | No         |
| spec.connection                             | enum: mysql                              | Database connection type                                                                                                                                                       | No         |
| spec.database                               | string                                   | Name of the schemahero database object                                                                                                                                         | No         |
| spec.primary_key                            | array                                    | List of column names as the primary key of the table                                                                                                                           | No         |
| spec.indexes.._NAME.columns                 | array                                    | Define columns in the index                                                                                                                                                    | No         |
| spec.indexes.._NAME.name                    | string                                   | Name of the index                                                                                                                                                              | No         |
| spec.indexes.._NAME.is_unique               | boolean                                  | Bool indicating a unique index                                                                                                                                                 | No         |
| spec.foreign_keys.._NAME.columns            | array                                    | Columns in the foreign key                                                                                                                                                     | No         |
| spec.foreign_keys.._NAME.references.table   | string                                   | Table name of the reference table                                                                                                                                              | No         |
| spec.foreign_keys.._NAME.references.columns | array                                    | Foreign table columns                                                                                                                                                          | No         |
| spec.columns.._NAME.name                    | string                                   | Name of the column                                                                                                                                                             | No         |
| spec.columns.._NAME.type                    | string                                   | Data type of the column                                                                                                                                                        | No         |
| spec.columns.._NAME.constraints             | object                                   | Adding constraints to the table                                                                                                                                                | No         |
| spec.columns.._NAME.attributes              | object                                   | Adding attributes to the column                                                                                                                                                | No         |
| advanced.default                            | object                                   | Spec values as per the API reference https://schemahero.io/reference/v1alpha4/table/                                                                                           | No         |

## Outputs

|     | Type   | Description                                       | Required   | Referencing                           |
|:----|:-------|:--------------------------------------------------|:-----------|:--------------------------------------|
| out | object | Output given by the resource for others to refer. | No         | ${schemahero_table.RESOURCE_NAME.out} |
