
parts:: {
  rules(host, paths) :: {
    host: host,
    http: {
      paths: paths
    }
  },

  path(path, serviceName, servicePort):: {
    path: path,
    backend: {
      serviceName: serviceName,
      servicePort: servicePort
    }
  },
}
