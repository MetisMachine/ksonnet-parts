// @apiVersion 0.1
// @name io.metismachine.pkg.ingress
// @description A basic Ingress resource for single service
// @shortDescription Ingress resource
// @param name string Name for the Ingress resource
// @param type string Type of Ingress Controller to use
// @param host string Domain name for Ingress resource
// @param serviceName string Name of service to use
// @optionalParam servicePort number 80 Port for the service
// @optionalParam path string / Path for routing rule

local ingress = import 'parts/ingress/ingress.libsonnet';

[
  {
    "apiVersion": "extensions/v1beta1",
    "kind": "Ingress",
    "metadata": {
      "name": import 'param://name',
      "annotations": {
        "kubernetes.io/ingress.class": import 'param://type'
      },
    },
    "spec": {
      "rules": [
        ingress.parts.rule(import 'param://host', [
          ingress.parts.path(
            import 'param://path',
            import 'param://serviceName',
            import 'param://servicePort'
          )
        ])
      ]
    }
  }
]

