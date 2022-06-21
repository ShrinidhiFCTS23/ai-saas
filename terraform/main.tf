locals{
  #Generated
  # Python raw json input with $mutations
  # Python merged with default -> application/default.json
  application_app1_input = {
    spec = {
      env ={
        # service2= "${application.service2.out.interfaces.grpc.host}"
        service2= "${module.application_service2.out.interfaces.grpc.host}"
        vpc = "${data.tf_remote_state.cluster_state.network.vpc_id}"
      }
    }
  }
  #configuration/instances/stack.json
  #merged with default -> stack/default.json
  stack_config = {

  }

  #configuration/instances/prometheus.json
  #merged with default -> prometheus/default.json
  prometheus_config = {

  }

  #Generated
  deployment_context = {

  }

}

data "tf_remote_state" "cluster_state"{

}
# Bootstrap
module "prometheus"{
  configuration = local.prometheus_config
  infra = data.tf_remote_state.cluster_state
  inputs = {
    stack = module.stack
  }
  depends_on = [module.stack]
}

# Bootstrap
module "stack"{
  configuration = local.stack_config
  infra = data.tf_remote_state.cluster_state
  depends_on = []
}

# Normal
module "application_app1"{
  instance = local.application_app1_input
  # Python to populate this based on file name
  instance_name = "app1"
  infra = data.tf_remote_state.cluster_state
  cc_metadata = deployment_context.cc_metadata
  inputs ={
    prometheus = module.prometheus
    stack = module.stack,
    application_service2 = module.application_service2
  }
  providers = {
    "tooling" = ""
  }
  depends_on = [
    module.prometheus,
    module.stack,
    module.application_service2
  ]
}

module "application_service2"{
  instance = local.application_app1_input
  # Python to populate this based on file name
  instance_name = "app1"
  infra = data.tf_remote_state.cluster_state
  cc_metadata = deployment_context.cc_metadata
  inputs ={
    prometheus = module.prometheus
    stack = module.stack
  }
  providers = {
    "tooling" = ""
  }
  depends_on = [
    module.prometheus,
    module.stack
  ]
}
