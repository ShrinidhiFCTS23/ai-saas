# Application

Application aka Service refers to any deployable piece of code which is stateless. There can be two types of
applications ones which always run as a service or intended to execute and successfully terminate.A special type of Job
is the Cronjob which has a schedule associated with it

## Features

- Support for integration with a CI system for image download.
- Support for tolerations in order to schedule the application on a particular nodegroup.
- Support HPA
  - CPU
  - Memory
  - Custom metrics
- Support Size
- Support to add environment variables
- Support to attach additional IAM permissions to the pod
- Support to set Health checks
- Support for metric collection by prometheus scrapping
  - Scrape duration?
- Support for sidecar injections
- Support for command and init container
- Support for volume and NFS mounts

## Implementation Details

