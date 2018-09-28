// @apiVersion 0.1
// @name io.metismachine.pkg.statefulset-service
// @description A stateful set with a service to expose container ports
// @shortDescription Statefulset with Service
// @param name string Name for resources
// @param image string Image to deploy
// @param mountPath string Path to mount PVC
// @param storageSize string Size for PVC, eg. "10Gi"
// @optionalParam servicePort number 80 Port for the service to expose.
// @optionalParam containerPort number 80 Container port for service to target.
// @optionalParam replicas number 1 Number of replicas
// @optionalParam type string ClusterIP Type of service to expose
// @optionalParam accessMode string ReadWriteOnce Access Mode for PVC

[
  {
    // required headless service for statefulset
    "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
        "name": std.format("%s-discover", import 'param://name')
      },
      "spec": {
        "ports": [
          {
            "port": import 'param://servicePort',
            "targetPort": import 'param://containerPort'
          }
        ],
        "selector": {
          "app": import 'param://name'
        },
        clusterIp: null
      }
  },
  {
    "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
        "name": import 'param://name'
      },
      "spec": {
        "ports": [
          {
            "port": import 'param://servicePort',
            "targetPort": import 'param://containerPort'
          }
        ],
        "selector": {
          "app": import 'param://name'
        },
        "type": import 'param://type'
      }
  },

  {
    apiVersion: apps/v1,
    kind: "StatefulSet",
    metadata: {
      name: import 'param://name'
    },
    spec: {
      selector: {
        matchLabels: {
          app: import 'param://name'
        }
      },
      serviceName: import 'param://name',
      replicas: import 'param://replicas',
      template: {
        metadata: {
          labels: {
            app: import 'param://name'
          }
        },
        spec: {
          containers: [
            {
              name: import 'param://name',
              image: import 'param://image',
              ports: [
                {
                  containerPort: import 'param://containerPort',
                }
              ],
              volumeMounts: [
                {
                  name: import 'param://name',
                  mountPath: import 'param://mountPath'
                }
              ]
            }
          ]
        }
      },
      volumeClaimTemplates: [
        {
          metadata: {
            name: import 'param://name'
          },
          spec: {
            accessModes: [import 'param://accessMode'],
            resources: {
              requests: {
                storage: import 'param://storageSize'
              }
            }
          }
        }
      ]
    }
  }
]
