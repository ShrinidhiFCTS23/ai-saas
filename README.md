# Intent Schema Guidelines

## Terms

| Term                                         | Description                                                                                                                              |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| **Resource**                                 | An entity declared in facets                                                                                                             |
| **Type of Resource** or **Intent**           | A resource expressible in facets JSON representation having a defined schema                                                             |
| **Implementation of Resource** or **Flavor** | A specific way of implementing a resource, for example redis can be implemented as a stateful set in kubernetes and elasticcache in AWS. |
| **Blueprint**                                | Collection of resource to create a functional product                                                                                    |
| **Environment**                              | Manifestation of this blueprint in any cloud                                                                                             |
| **User**                                     | Developer or ops person who is creating the blueprint                                                                                    |

## Anatomy of a Facets Resource JSON

### Introduction
In Facets, a resource is described using a JSON file that follows a specific schema. This schema defines the different properties of a resource and how it should be provisioned within an environment. In this document, we will outline the anatomy of a resource JSON file in Facets and explain the various properties it contains.

#### Kind:
The kind property specifies the type of resource that the JSON file represents. For example, it could be an ingress, an application, a MySQL database, etc. If this property is not specified, the default value is the folder name/instances.

#### Flavor:
The flavor property is used to select a specific implementation of the resource type. For example, for a resource type of ingress, a flavor of default, aws_alb, or gcp_alb could be specified. This property allows for flexibility in choosing the implementation that best fits the needs of the environment.

#### Version:
The version property is used to specify a particular version of the resource implementation. This is useful when there are multiple versions of an implementation available, and you want to pin the resource to a specific version. The default version is the latest version available.

#### Disabled:
The disabled property is a boolean flag that allows the user to disable the resource. This is useful when a resource is not needed or is temporarily unavailable.

#### Provided:
The provided property is a boolean flag that specifies whether the resource should be provisioned by Facets or not. For example, a MySQL database may be provisioned outside of Facets, but can still exist within the blueprint for other resources to refer to its URL, username, etc. In this case, the provided property would be set to true, and the out section would be populated by the user.

#### Depends On:
The depends_on property lists any dependencies that the resource has on other resources. For example, an application may depend on a MySQL database. The depends_on property would be set to ["mysql.y"].

#### Metadata:
The metadata property contains metadata related to the resource. This includes the name of the resource and any other relevant information. If the name property is not specified, the default value is the file name.

#### Spec:
The spec property contains the specification for the resource. This is where the specific details of the resource are defined, and it follows the schema for the specific resource type.

#### Out:
The out property contains the output given by the resource for others to refer. This includes any relevant information that other resources may need to use, such as URLs, usernames, and passwords. The out section follows the schema for the specific resource type.

#### Advanced:
The advanced property is an optional field that contains additional fields that are specific to a particular implementation of a resource. This allows for greater customization and configuration of the resource beyond the standard fields.

# Supported Services

| Kind                 | Flavor            | Version | Schema                                                                                                | Sample                                                                    | Readme                                                          |
|----------------------|-------------------|---------|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|-----------------------------------------------------------------|
| mysql                | cloudsql          | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/mysql/mysql.schema.json                         | [Sample](schemas/mysql/mysql.cloudsql.sample.json)                        | [Readme](schemas/mysql/mysql.schema.md)                         |
| mysql                | rds               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/mysql/mysql.schema.json                         | [Sample](schemas/mysql/mysql.rds.sample.json)                             | [Readme](schemas/mysql/mysql.schema.md)                         |
| mysql                | aurora            | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/mysql/mysql.schema.json                         | [Sample](schemas/mysql/mysql.aurora.sample.json)                          | [Readme](schemas/mysql/mysql.schema.md)                         |
| mysql                | flexible_server   | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/mysql/mysql.schema.json                         | [Sample](schemas/mysql/mysql.flexible_server.sample.json)                 | [Readme](schemas/mysql/mysql.schema.md)                         |
| redis                | azure_cache       | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/redis/redis.schema.json                         | [Sample](schemas/redis/redis.sample.json)                                 | [Readme](schemas/redis/redis.schema.md)                         |
| redis                | elasticache       | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/redis/redis.schema.json                         | [Sample](schemas/redis/redis.sample.json)                                 | [Readme](schemas/redis/redis.schema.md)                         |
| redis                | memorystore       | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/redis/redis.schema.json                         | [Sample](schemas/redis/redis.sample.json)                                 | [Readme](schemas/redis/redis.schema.md)                         |
| redis                | k8s               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/redis/redis.schema.json                         | [Sample](schemas/redis/redis.sample.json)                                 | [Readme](schemas/redis/redis.schema.md)                         |
| ingress              | nlb_nginx         | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/loadbalancer/ingress.schema.json                | [Sample](schemas/loadbalancer/ingress.nlb_ngnix.sample.json)              | [Readme](schemas/loadbalancer/ingress.schema.md)                |
| ingress              | gcp_alb           | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/loadbalancer/ingress.schema.json                | [Sample](schemas/loadbalancer/ingress.gcp_alb.sample.json)                | [Readme](schemas/loadbalancer/ingress.schema.md)                |
| ingress              | aws_alb           | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/loadbalancer/ingress.schema.json                | [Sample](schemas/loadbalancer/ingress.aws_alb.sample.json)                | [Readme](schemas/loadbalancer/ingress.schema.md)                |
| service              | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/service/service.schema.json                     | [Sample](schemas/service/service.default.sample.json)                     | [Readme](schemas/service/service.schema.md)                     |
| postgres             | aurora            | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/postgres/postgres.schema.json                   | [Sample](schemas/postgres/postgres.aurora.sample.json)                    | [Readme](schemas/postgres/postgres.schema.md)                   |
| postgres             | cloudsql          | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/postgres/postgres.schema.json                   | [Sample](schemas/postgres/postgres.cloudsql.sample.json)                  | [Readme](schemas/postgres/postgres.schema.md)                   |
| kubernetes_node_pool | aks               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/nodepool/nodepool.schema.json                   | [Sample](schemas/nodepool/nodepool.aks.sample.json)                       | [Readme](schemas/nodepool/nodepool.schema.md)                   |
| kubernetes_node_pool | eks_managed       | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/nodepool/nodepool.schema.json                   | [Sample](schemas/nodepool/nodepool.eks_managed.sample.json)               | [Readme](schemas/nodepool/nodepool.schema.md)                   |
| kubernetes_node_pool | eks_self_managed  | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/nodepool/nodepool.schema.json                   | [Sample](schemas/nodepool/nodepool.eks_self_managed.sample.json)          | [Readme](schemas/nodepool/nodepool.schema.md)                   |
| k8s_resource         | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/k8s_resource/k8s_resource.schema.json           | [Sample](schemas/k8s_resource/k8s_resource.default.sample.json)           | [Readme](schemas/k8s_resource/k8s_resource.schema.md)           |
| s3                   | default           | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/s3/s3.schema.json                               | [Sample](schemas/s3/s3.default.sample.json)                               | [Readme](schemas/s3/s3.schema.md)                               |
| alert_group          | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/alert_group/alert_group.schema.json             | [Sample](schemas/alert_group/alert_group.default.sample.json)             | [Readme](schemas/alert_group/alert_group.schema.md)             |
| alert_group          | loki              | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/alert_group/alert_group.schema.json             | [Sample](schemas/alert_group/alert_group.loki.sample.json)                | [Readme](schemas/alert_group/alert_group.schema.md)             |
| log_collector        | loki              | 0.1, 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/log_collector/log_collector.schema.json         | [Sample](schemas/log_collector/log_collector.loki.sample.json)            | [Readme](schemas/log_collector/log_collector.schema.md)         |
| log_collector        | loki_s3           | 0.1, 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/log_collector/log_collector.schema.json         | [Sample](schemas/log_collector/log_collector.loki_s3.sample.json)         | [Readme](schemas/log_collector/log_collector.schema.md)         |
| log_collector        | loki_blob          | 0.1, 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/log_collector/log_collector.schema.json         | [Sample](schemas/log_collector/log_collector.loki_blob.sample.json)         | [Readme](schemas/log_collector/log_collector.schema.md)         |
| log_collector        | loki_gcs           | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/log_collector/log_collector.schema.json         | [Sample](schemas/log_collector/log_collector.loki_gcs.sample.json)         | [Readme](schemas/log_collector/log_collector.schema.md)         |
| sqs                  | default           | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/sqs/sqs.schema.json                             | [Sample](schemas/sqs/sqs.default.sample.json)                             | [Readme](schemas/sqs/sqs.schema.md)                             |
| helm                 | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/helm/helm.schema.json                           | [Sample](schemas/helm/helm.helm_simple.sample.json)                       | [Readme](schemas/helm/helm.schema.md)                           |
| mongo                | k8s               | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/mongo/mongo.schema.json                         | [Sample](schemas/mongo/mongo.k8s.sample.json)                             | [Readme](schemas/mongo/mongo.schema.md)                         |
| elasticsearch        | k8s               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/elasticsearch/elasticsearch.schema.json         | [Sample](schemas/elasticsearch/elasticsearch.k8s.sample.json)             | [Readme](schemas/elasticsearch/elasticsearch.schema.md)         |
| rabbitmq             | k8s               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/rabbitmq/rabbitmq.schema.json                   | [Sample](schemas/rabbitmq/rabbitmq.k8s.sample.json)                       | [Readme](schemas/rabbitmq/rabbitmq.schema.md)                   |
| kafka                | k8s               | 0.2     | https://facets-cloud.github.io/facets-schemas/schemas/kafka/kafka.schema.json                         | [Sample](schemas/kafka/kafka.k8s.sample.json)                             | [Readme](schemas/kafka/kafka.schema.md)                         |
| kafka                | msk               | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/kafka/kafka.schema.json                         | [Sample](schemas/kafka/kafka.msk.sample.json)                             | [Readme](schemas/kafka/kafka.msk.schema.md)                     |
| grafana_dashboard    | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/grafana_dashboard/grafana-dashboard.schema.json | [Sample](schemas/grafana_dashboard/grafana_dashboard.default.sample.json) | [Readme](schemas/grafana_dashboard/grafana_dashboard.schema.md) |
| config_map           | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/config_map/config_map.schema.json               | [Sample](schemas/config_map/config_map.k8s.sample.json)                   | [Readme](schemas/config_map/config_map.schema.md)               |
| cloudfront           | default           | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/cloudfront/cloudfront.schema.json               | [Sample](schemas/cloudfront/cloudfront.default.sample.json)               | [Readme](schemas/cloudfront/cloudfront.schema.md)               |
| service_bus          | azure_service_bus | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/service_bus.azure_service_bus.schema.json       | [Sample](schemas/service_bus/service_bus.azure_service_bus.schema.json)   | [Readme](schemas/service_bus/service_bus.schema.md)             |
| google_cloud_storage          | default | 0.1     | https://facets-cloud.github.io/facets-schemas/schemas/google_cloud_storage.schema.json       | [Sample](schemas/google_cloud_storage/google_cloud_storage.schema.json)   | [Readme](schemas/google_cloud_storage/google_cloud_storage.schema.md)             |


## Additional links

| Topic                                        | Link                                                                                                  |
| -------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Artifact Management                          | [Link](facets-docs/register-artifact.md)                                                              |
| accounts-concept                             | [Link](facets-docs/Concepts/accounts.md)                                                              |
| artifacts-concept                            | [Link](facets-docs/Concepts/artifacts.md)                                                             |
| blueprint-concept                            | [Link](facets-docs/Concepts/blueprint.md)                                                             |
| controlplnae-concept                         | [Link](facets-docs/Concepts/control-plane.md)                                                         |
| environment-concept                          | [Link](facets-docs/Concepts/control-plane.md)                                                         |
| iac-concept                                  | [Link](facets-docs/Concepts/iac-using-facets.md)                                                      |
| introduction-concept                         | [Link](facets-docs/Concepts/introduction-to-concepts.md)                                              |
| release-concept                              | [Link](facets-docs/Concepts/releases-concept.md)                                                      |
| resource-json-concept                        | [Link](facets-docs/Concepts/resource-json.md)                                                         |
| authentication-setup                         | [Link](facets-docs/Deployment%20Controller/authentication-setup.md)                                   |
| Customer-support                             | [Link](facets-docs/Deployment%20Controller/customer-support-process.md)                               |
| Override-clone                               | [Link](facets-docs/Deployment%20Controller/override-resource-definition-in-an-environment-clone.md)   |
| Override                                     | [Link](facets-docs/Deployment%20Controller/override-resource-defintion-in-an-environment.md)          |
| trigger-hotfix-release                       | [Link](facets-docs/Deployment%20Controller/trigger-a-hotfix-release.md)                               |
| trigger-release                              | [Link](facets-docs/Deployment%20Controller/trigger-a-release.md)                                      |
| continuous-delivery-pipeline                 | [Link](facets-docs/Environments/continuous-delivery-pipelines.md)                                     |
| environment variables                        | [Link](facets-docs/Environments/environment-variables-and-secrets.md)                                 |
| deploy-app-example-part-1                    | [Link](facets-docs/Example%20Guides/deploy-a-simple-flask-application/part-1-deploy-the-flask-app.md) |
| connect-mongo-app-example-part-2             | [Link](facets-docs/Example%20Guides/deploy-a-simple-flask-application/part-2-connect-a-mongodb.md)    |
| deploy-sample-app                            | [Link](facets-docs/Example%20Guides/deploy-a-simple-flask-application.md)                             |
| self-host-kill-bill                          | [Link](facets-docs/Example%20Guides/self-host-kill-bill.md)                                           |
| build-vs-buy                                 | [Link](facets-docs/Facets-Cloud%20Primer/build-vs-buy.md)                                             |
| facets-vs-terraform                          | [Link](facets-docs/Facets-Cloud%20Primer/facets-vs-terraform.md)                                      |
| getting-started                              | [Link](facets-docs/Facets-Cloud%20Primer/getting-started.md)                                          |
| supported platforms                          | [Link](facets-docs/Facets-Cloud%20Primer/supported-platforms-and-services.md)                         |
| ci-integrations                              | [Link](facets-docs/Feature%20Guides/ci-integration.md)                                                |
| landing-page                                 | [Link](facets-docs/Feature%20Guides/landing-page-guides.md)                                           |
| managing-iac                                 | [Link](facets-docs/Feature%20Guides/manage-iac-versions.md)                                           |
| peering                                      | [Link](facets-docs/Feature%20Guides/peering.md)                                                       |
| user-access                                  | [Link](facets-docs/Feature%20Guides/restrict-user-access-to-environments.md)                          |
| template-inputs                              | [Link](facets-docs/Feature%20Guides/template-inputs.md)                                               |
| user-management                              | [Link](facets-docs/Feature%20Guides/user-management.md)                                               |
| blueprint-designer                           | [Link](facets-docs/Features/blueprint-designer.md)                                                    |
| cost-explorer                                | [Link](facets-docs/Features/cloud-cost-explorer.md)                                                   |
| facets-ctl                                   | [Link](facets-docs/Features/command-line-tool-for-facets.md)                                          |
| config-service                               | [Link](facets-docs/Features/configuration-management-for-services.md)                                 |
| external-tools                               | [Link](facets-docs/Features/external-tools-and-usage.md)                                              |
| notifications                                | [Link](facets-docs/Features/notifications.md)                                                         |
| pipeline                                     | [Link](facets-docs/Features/pipeline.md)                                                              |
| user-management-2                            | [Link](facets-docs/Features/user-management-2.md)                                                     |
| create an environment                        | [Link](facets-docs/Getting%20Started/create-an-environment.md)                                        |
| create your blueprint                        | [Link](facets-docs/Getting%20Started/create-your-first-blueprint.md)                                  |
| incremental-migration                        | [Link](facets-docs/Getting%20Started/incremental-migration.md)                                        |
| launch an environment                        | [Link](facets-docs/Getting%20Started/launch-environment.md)                                           |
| setup controlplane                           | [Link](facets-docs/Getting%20Started/setup-your-control-plane.md)                                     |
| adding a resource                            | [Link](facets-docs/Guides/adding-resources.md)                                                        |
| artifact history and rollback                | [Link](facets-docs/Guides/artifact-history-and-rollback.md)                                           |
| centralized override management              | [Link](facets-docs/Guides/centralized-override-management.md)                                         |
| ci-rules                                     | [Link](facets-docs/Guides/ci-rules.md)                                                                |
| creating a ci integration                    | [Link](facets-docs/Guides/creating-a-ci-integration.md)                                               |
| creating promotion workflow                  | [Link](facets-docs/Guides/creating-a-promotion-workflow.md)                                           |
| Custom release streams                       | [Link](facets-docs/Guides/custom-release-streams.md)                                                  |
| integrating cloud accounts                   | [Link](facets-docs/Guides/integrating-cloud-accounts.md)                                              |
| integrating vcs accounts                     | [Link](facets-docs/Guides/integrating-vcs-accounts.md)                                                |
| manage iac                                   | [Link](facets-docs/Guides/manage-iac.md)                                                              |
| map custom domains                           | [Link](facets-docs/Guides/map-custom-domains.md)                                                      |
| notifications channels subscription          | [Link](facets-docs/Guides/notification-channels-subscriptions.md)                                     |
| performing release                           | [Link](facets-docs/Guides/performing-releases.md)                                                     |
| rolling restart of pods                      | [Link](facets-docs/Guides/rolling-restart-of-pods.md)                                                 |
| scheduling releases                          | [Link](facets-docs/Guides/scheduling-releases.md)                                                     |
| setting delivery pipeline                    | [Link](facets-docs/Guides/setting-up-the-delivery-pipeline.md)                                        |
| view dashboard for k8s events in grafana     | [Link](facets-docs/Guides/viewing-persistent-dashboard-for-k8s-events-in-grafana.md)                  |
| default ci rule using api                    | [Link](facets-docs/Modifying%20Default%20CI%20Rule/default-ci-rule-using-api.md)                      |
| get artifact routing rule                    | [Link](facets-docs/Modifying%20Default%20CI%20Rule/get-artifact-routing-rule.md)                      |
| update artifact routing rule                 | [Link](facets-docs/Modifying%20Default%20CI%20Rule/update-artifact-routing-rule.md)                   |
| modules                                      | [Link](facets-docs/Modules/modules.md)                                                                |
| advanced filters for notifications           | [Link](facets-docs/Notifications/advanced-filters-for-notifications.md)                               |
| release                                      | [Link](facets-docs/Releases-%20Rollbacks%20and%20Restarts/releases.md)                                |
| override resource in cluster                 | [Link](facets-docs/Resources/overriding-resources-in-a-cluster.md)                                    |
| resource center                              | [Link](facets-docs/Resources/resource-center.md)                                                      |
| toggle a resource in an environment          | [Link](facets-docs/Resources/toggle-an-application-in-an-environment.md)                              |
| resource details                             | [Link](facets-docs/Resources/resource-center/resource-details.md)                                     |
| resource type application                    | [Link](facets-docs/Resources/resource-center/resource-type-application.md)                            |
| registering an artifact                      | [Link](facets-docs/Service/registering-an-artifact.md)                                                |
| Tools and dashboards                         | [Link](facets-docs/Tools%20and%20Dashboards/access-wetty-from-facets-control-plane.md)                |
| creating a user group                        | [Link](facets-docs/User%20Management/creating-a-user-group.md)                                        |
| creating a user                              | [Link](facets-docs/User%20Management/creating-a-user.md)                                              |
| custom roles                                 | [Link](facets-docs/User%20Management/custom-roles.md)                                                 |
| google oauth integration                     | [Link](facets-docs/User%20Management/google-oauth-integration-for-user-management.md)                 |
| integrating with azure aad                   | [Link](facets-docs/User%20Management/integrating-with-azure-ad.md)                                    |
| integrating with okta                        | [Link](facets-docs/User%20Management/integrating-with-okta.md)                                        |
| integrating with onelogin                    | [Link](facets-docs/User%20Management/integrating-with-onelogin.md)                                    |
| user management 1                            | [Link](facets-docs/User%20Management/user-management-1.md)                                            |
| user management permissions                  | [Link](facets-docs/User%20Management/user-management-permissions.md)                                  |
| get list of n artifacts                      | [Link](facets-docs/Versioned%20Resources/get-list-of-n-artifacts.md)                                  |
| get versioning key                           | [Link](facets-docs/Versioned%20Resources/get-versioning-key.md)                                       |
| rollback an artifact for a specific resource | [Link](facets-docs/Versioned%20Resources/rollback-an-artifact-for-a-specific-resource.md)             |
|  trigger rollback for an artifact                                            | [Link](facets-docs/Versioned%20Resources/trigger-rollback-for-an-artifact.md)                                                                                                      |

