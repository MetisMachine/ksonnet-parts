// @apiVersion 0.1
// @name io.metismachine.pkg.deployment
// @description A deployment without a service
// @shortDescription A deployment 
// @param name string Name of the deployment resource
// @param image string Container image to deploy
// @optionalParam replicas number 1 Number of replicas

[
   {
      "apiVersion": "apps/v1beta2",
      "kind": "Deployment",
      "metadata": {
         "name": import 'param://name'
      },
      "spec": {
         "replicas": import 'param://replicas',
         "selector": {
            "matchLabels": {
               "app": import 'param://name'
            },
         },
         "template": {
            "metadata": {
               "labels": {
                  "app": import 'param://name'
               }
            },
            "spec": {
               "containers": [
                  {
                     "image": import 'param://image',
                     "name": import 'param://name',
                  }
               ]
            }
         }
      }
   }
]
