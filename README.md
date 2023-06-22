# RapidPro Helm Chart

This helm installs RapidPro, Mailroom, Courier and provides the option to install PostgreSQL, Redis and elasticsearch or use external services.

## Prerequisites
1. Kubernetes 1.9+
2. Helm 3.0.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release onaio/rapidpro
```

The command deploys RapidPro on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the RapidPro chart and their default values. Complete list of parameters can be found in [values.yaml](values.yaml).

### Global Parameters
These parameters are common to all the components of the chart.

Parameter | Description | Default
---       | ---         | ---
`awsAccessKeyId` | AWS access key id | `""`
`awsSecretAccessKey` | AWS secret access key | `""`
`awsStorageBucketName` | AWS storage bucket Name| `""`
`awsS3RegionName` | AWS storage bucket region | `""``
`rapidproDomain` | RapidPro domain | `"rapidpro.local"`
`securityContext` | Security context for the pods | `{}`
`smtp.host` | SMTP host address | `""`
`smtp.port` | SMTP port | `""`
`smtp.username` | SMTP username | `""`
`smtp.password` | SMTP password | `""`
`smtp.defaultFrom` | SMTP default from Email Address | `""`
`smtp.useTLS` | SMTP use TLS | `on`

### RapidPro Parameters
These parameters are specific to the RapidPro component of the chart.
Parameter | Description | Default
---       | ---         | ---
`rapidpro.image.repository` | RapidPro image repository | `"morrismukiri/rapidpro"`
`rapidpro.image.tag` | RapidPro image tag | `"7.4.2"`
`rapidpro.image.pullPolicy` | RapidPro image pull policy | `"IfNotPresent"`
`rapidpro.autoscaling.enabled` | Enable autoscaling | `false`
`rapidpro.autoscaling.minReplicas` | Minimum number of replicas | `1`
`rapidpro.autoscaling.maxReplicas` | Maximum number of replicas | `100`
`rapidpro.service.type` | Kubernetes service type | `"ClusterIP"`
`rapidpro.service.port` | Kubernetes service port | `80`
`rapidpro.service.targetPort` | Kubernetes service target port | `8000`
`rapidpro.ingress.enabled` | Enable ingress | `false`
`rapidpro.ingress.annotations` | Ingress annotations | `{}`
`rapidpro.ingress.className` | Ingress class name | `""`
`rapidpro.ingress.tls` | Ingress TLS configuration | `[]`
`rapidpro.secretKey` | RapidPro secret key | `""`
`rapipro.extraEnvVars` | Extra environment variables to set in the RapidPro configmap. Refer to the [settings.py](https://github.com/morrismukiri/rapidpro-docker/blob/master/settings.py) for environment variables to set | `[]`
`rapidpro.extraEnvSecrets` | Extra environment variables to be added to RapidPro Kubernetes secrets. Refer to the [settings.py](https://github.com/morrismukiri/rapidpro-docker/blob/master/settings.py) for environment variables to set | `[]`
`rapidpro.runMigrations` | Run migrations on startup | `on`
`rapidpro.runCollectStatic` | Run collectstatic on startup | `on`
`rapidpro.runCompress` | Run compress on startup | `on`
`rapidpro.clearCompressorCache` | Clear compressor cache on startup | `on`
`rapidpro.resources` | CPU/Memory resource requests/limits | `{}`
`rapidpro.podAnnotations` | Annotations to add to the RapidPro pods | `{}`
`rapidpro.nodeSelector` | Node labels for RapidPro pod assignment | `{}`
`rapidpro.tolerations` | Tolerations for RapidPro pod assignment | `[]`
`rapidpro.affinity` | Affinity for RapidPro pod assignment | `{}`


### Mailroom Parameters
These parameters are specific to the Mailroom component of the chart.
Parameter | Description | Default
---       | ---         | ---
`mailroom.authToken` | Mailroom auth token | `""`
`mailroom.listenAddress` | Mailroom listen addres. This is the address Mailroom will listen on | `"0.0.0.0"`
`mailroom.image.repository` | Mailroom image repository | `"praekeltfoundation/mailroom"`
`mailroom.image.tag` | Mailroom image tag. Default value is null, which will use the chart app version | `"null"`
`mailroom.image.pullPolicy` | Mailroom image pull policy | `"IfNotPresent"`
`mailroom.autoscaling.enabled` | Enable autoscaling | `false`
`mailroom.autoscaling.minReplicas` | Minimum number of replicas | `1`
`mailroom.autoscaling.maxReplicas` | Maximum number of replicas | `100`
`mailroom.service.type` | Kubernetes service type | `"ClusterIP"`
`mailroom.service.port` | Kubernetes service port | `8090`
`mailroom.service.targetPort` | Kubernetes service target port | `8090`
`mailroom.extraEnvVars` | Extra environment variables to set in the Mailroom configmap. Refer to the Mailroom documentation [here](https://github.com/rapidpro/mailroom#configuration) for environment variables to set | `[]`
`mailroom.extraEnvSecrets` | Extra environment variables to be added to Mailroom Kubernetes secrets Refer to the Mailroom documentation [here](https://github.com/rapidpro/mailroom#configuration) for environment variables to set | `[]`
`mailroom.podAnnotations` | Annotations to add to the Mailroom pods | `{}`
`mailroom.resources` | CPU/Memory resource requests/limits | `{}`
`mailroom.nodeSelector` | Node labels for Mailroom pod assignment | `{}`
`mailroom.tolerations` | Tolerations for Mailroom pod assignment | `[]`
`mailroom.affinity` | Affinity for Mailroom pod assignment | `{}`
`mailroom.podSecurityContext` | Security context for the Mailroom pods | `{}`

### Courier Parameters
These parameters are specific to the Courier component of the chart.
Parameter | Description | Default
---       | ---         | ---
`courier.image.repository` | Courier image repository | `"praekeltfoundation/courier"`
`courier.image.tag` | Courier image tag. Default value is null, which will use the chart app version | `"null"`
`courier.image.pullPolicy` | Courier image pull policy | `"IfNotPresent"`
`courier.autoscaling.enabled` | Enable autoscaling | `false`
`courier.autoscaling.minReplicas` | Minimum number of replicas | `1`
`courier.autoscaling.maxReplicas` | Maximum number of replicas | `100`
`courier.service.type` | Kubernetes service type | `"ClusterIP"`
`courier.service.port` | Kubernetes service port | `8080`
`courier.extraEnvVars` | Extra environment variables to set in the Courier configmap. Refer to the Courier documentation [here](https://github.com/nyaruka/courier#rapidpro) for environment variables to set | `[]`
`courier.extraEnvSecrets` | Extra environment variables to be added to Courier Kubernetes secrets Refer to the Courier documentation [here](https://github.com/nyaruka/courier#rapidpro) for environment variables to set | `[]`
`courier.spoolDirectory` | Courier spool directory where courier can spool files if the database is down. The path is mounted to an [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) volume that will be deleted when the pod is deleted | `"/home/courier/spool"`
`courier.podAnnotations` | Annotations to add to the Courier pods | `{}`
`courier.resources` | CPU/Memory resource requests/limits | `{}`
`courier.nodeSelector` | Node labels for Courier pod assignment | `{}`
`courier.tolerations` | Tolerations for Courier pod assignment | `[]`
`courier.affinity` | Affinity for Courier pod assignment | `{}`
`courier.podSecurityContext` | Security context for the Courier pods | `{}`

### RapidPro Indexer Parameters
These parameters are specific to the RapidPro Indexer component of the chart.
Parameter | Description | Default
---       | ---         | ---
`indexer.image.repository` | RapidPro Indexer image repository | `"praekeltfoundation/rapidpro-indexer"`
`indexer.image.tag` | RapidPro Indexer image tag. Default value is null, which will use the chart app version | `"null"`
`indexer.image.pullPolicy` | RapidPro Indexer image pull policy | `"IfNotPresent"`
`indexer.autoscaling.enabled` | Enable autoscaling | `false`
`indexer.autoscaling.minReplicas` | Minimum number of replicas | `1`
`indexer.autoscaling.maxReplicas` | Maximum number of replicas | `100`
`indexer.targetCPUUtilizationPercentage` | Target CPU utilization percentage for the indexer | `80`
`indexer.extraEnvVars` | Extra environment variables to set in the RapidPro Indexer configmap. Refer to the RapidPro Indexer documentation [here](https://github.com/nyaruka/rp-indexer#rapidpro) for environment variables to set | `[]`
`indexer.extraEnvSecrets` | Extra environment variables to be added to RapidPro Indexer Kubernetes secrets. Refer to the RapidPro Indexer documentation [here](https://github.com/nyaruka/rp-indexer#rapidpro) for environment variables to set | `[]`


### RapidPro Archiver Parameters
These parameters are specific to the RapidPro Archiver component of the chart.
Parameter | Description | Default
---       | ---         | ---
`archiver.image.repository` | RapidPro Archiver image repository | `"praekeltfoundation/rapidpro-indexer"`
`archiver.image.tag` | RapidPro Archiver image tag. Default value is null, which will use the chart app version | `"null"`
`archiver.image.pullPolicy` | RapidPro Archiver image pull policy | `"IfNotPresent"`
`archiver.autoscaling.enabled` | Enable autoscaling | `false`
`archiver.autoscaling.minReplicas` | Minimum number of replicas | `1`
`archiver.autoscaling.maxReplicas` | Maximum number of replicas | `100`
`archiver.targetCPUUtilizationPercentage` | Target CPU utilization percentage for the indexer | `80`
`archiver.extraEnvVars` | Extra environment variables to set in the RapidPro Archiver configmap. Refer to the RapidPro Archiver documentation [here](https://github.com/nyaruka/rp-archiver#rapidpro) for environment variables to set | `[]`
`archiver.extraEnvSecrets` | Extra environment variables to be added to RapidPro Archiver Kubernetes secrets. Refer to the RapidPro Archiver documentation [here](https://github.com/nyaruka/rp-archiver#rapidpro) for environment variables to set | `[]`

### Redis Parameters
To use an external Redis instance, set `redis.enabled` to `false` and set the `externalRedisUrl` parameter to the URL of the external Redis instance. The URL should be in the format `redis://<host>:<port>/<db>`. The default db is 15.

To use the Redis instance that is installed with the chart, set `redis.enabled` to `true`. The Redis instance will be installed with the default values for the [Bitnami Redis chart](https://github.com/bitnami/charts/tree/main/bitnami/redis/#parameters). The Redis instance will be installed in the same namespace as the RapidPro chart.

These are the default parameters that this chart sets for the Redis instance that is installed with the chart. To override these parameters, set the `redis` parameter to the values you want to override. For example, to set the Redis password, set the `redis.image.tag` parameter to the Redis container image tag you want to use.

Parameter | Description | Default
---       | ---         | ---
`redis.enabled` | Enable the Redis instance that is installed with the chart | `true`
`redis.image.tag` | Redis image tag. Default value is null, which will use the chart app version | `"6.2.5"`
`redis.service.type` | Kubernetes service type | `"ClusterIP"`
`redis.service.port` | Kubernetes service port | `6379`
`redis.persistence.enabled` | Enable persistence using PVC. The default value is false since RapidPro does not require Redis persistence | `false`
`redis.auth.enabled` | Enable Redis authentication. | `false`

### PostgreSQL Parameters

To use an external PostgreSQL set `postgresql.enabled` to `false` and `externalPostgresqlUrl` to the URL of the external PostgreSQL instance. For example, if you are using a PostgreSQL instance on AWS RDS, set `externalPostgresqlUrl` to `postgres://<username>:<password>@<host>:<port>/<database>`.

To use the PostgreSQL instance that is installed with the chart, set `postgresql.enabled` to `true`. The PostgreSQL instance will be installed with the default values for the [Bitnami PostgreSQL chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql/#parameters). The PostgreSQL instance will be installed in the same namespace as the RapidPro chart.

These are the default parameters that this chart sets for the PostgreSQL instance that is installed with the chart. To override these parameters, set the `postgresql` parameter to the values you want to override. For example, to set the PostgreSQL password, set the `postgresql.auth.postgresPassword` parameter to the password you want to use.

Parameter | Description | Default
---       | ---         | ---
`postgresql.enabled` | Enable the PostgreSQL instance that is installed with the chart | `true`
`postgresql.image.tag` | PostgreSQL image tag. Default value is null, which will use the chart app version | `"13.4.0-debian-10-r0"`
`postgresql.service.type` | Kubernetes service type | `"ClusterIP"`
`postgresql.service.port` | Kubernetes service port | `5432`
`postgresql.persistence.enabled` | Enable persistence using PVC. The default value is false since RapidPro does not require PostgreSQL persistence | `false`
`postgresql.persistence.size` | PVC Storage Request for PostgreSQL volume | `40Gi`

### Elasticsearch Parameters

To use an external Elasticsearch instance, set `elasticsearch.enabled` to `false` and set the `externalElasticsearchUrl` parameter to the URL of the external Elasticsearch instance. The URL should be in the format `http://<host>:<port>`.

To use the Elasticsearch instance that is installed with the chart, set `elasticsearch.enabled` to `true`. The Elasticsearch instance will be installed with the default values for the [Bitnami Elasticsearch chart](https://github.com/bitnami/charts/tree/main/bitnami/elasticsearch/#parameters). The Elasticsearch instance will be installed in the same namespace as the RapidPro chart.

These are the default parameters that this chart sets for the Elasticsearch instance that is installed with the chart. To override these parameters, set the `elasticsearch` parameter to the values you want to override. For example, to set the Elasticsearch password, set the `elasticsearch.image.tag` parameter to the Elasticsearch container image tag you want to use.

Parameter | Description | Default
---       | ---         | ---
`elasticsearch.enabled` | Enable the Elasticsearch instance that is installed with the chart | `true`
`elasticsearch.image.tag` | Elasticsearch image tag. Default value is null, which will use the chart app version | `"7.13.4-debian-10-r0"`
`elasticsearch.service.type` | Kubernetes service type | `"ClusterIP"`
`elasticsearch.service.port` | Kubernetes service port | `9200`
`elasticsearch.persistence.enabled` | Enable persistence using PVC. The default value is false since RapidPro does not require Elasticsearch persistence | `true`
`elasticsearch.persistence.size` | PVC Storage Request for Elasticsearch volume | `40Gi`
