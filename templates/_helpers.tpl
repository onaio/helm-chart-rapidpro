{{/*
Expand the name of the chart.
*/}}
{{- define "rapidpro.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rapidpro.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rapidpro.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rapidpro.labels" -}}
helm.sh/chart: {{ include "rapidpro.chart" . }}
{{ include "rapidpro.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Mailroom labels
*/}}
{{- define "mailroom.labels" -}}
helm.sh/chart: {{ include "rapidpro.chart" . }}
{{ include "mailroom.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.mailroom.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Courier labels
*/}}
{{- define "courier.labels" -}}
helm.sh/chart: {{ include "rapidpro.chart" . }}
{{ include "courier.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.courier.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Indexer labels
*/}}
{{- define "indexer.labels" -}}
helm.sh/chart: {{ include "rapidpro.chart" . }}
{{ include "indexer.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.indexer.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Archiver labels
*/}}
{{- define "archiver.labels" -}}
{{- if .Values.archiver.enabled }}
helm.sh/chart: {{ include "rapidpro.chart" . }}
{{ include "archiver.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.archiver.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- end }}

{{/*
RapidPro Selector labels
*/}}
{{- define "rapidpro.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rapidpro.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Mailroom Selector labels
*/}}
{{- define "mailroom.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rapidpro.name" . }}-mailroom
app.kubernetes.io/instance: {{ .Release.Name }}-mailroom
{{- end }}

{{/*
Courier Selector labels
*/}}
{{- define "courier.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rapidpro.name" . }}-courier
app.kubernetes.io/instance: {{ .Release.Name }}-courier
{{- end }}

{{/*
{{- end }}

{{/*
indexer Selector labels
*/}}
{{- define "indexer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rapidpro.name" . }}-indexer
app.kubernetes.io/instance: {{ .Release.Name }}-indexer
{{- end }}

{{/*
Archiver Selector labels
*/}}
{{- define "archiver.selectorLabels" -}}
{{- if .Values.archiver.enabled }}
app.kubernetes.io/name: {{ include "rapidpro.name" . }}-archiver
app.kubernetes.io/instance: {{ .Release.Name }}-archiver
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rapidpro.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rapidpro.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create smtp url from values
*/}}
{{- define "rapidpro.smtpUrl" -}}
{{- printf "smtp://%s:%s@%s:%v" .Values.smtp.username .Values.smtp.password .Values.smtp.host .Values.smtp.port -}}
{{- end }}

{{/* database URL
*/}}
{{- define "rapidpro.databaseUrl" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "postgres://%s:%s@%s-%s:%v/%s" "postgres" .Values.postgresql.auth.postgresPassword (include "rapidpro.fullname" . ) "postgresql" .Values.postgresql.service.port .Values.postgresql.auth.database -}}
{{- else }}
{{-  printf "%s" .Values.externalPostgresqlUrl -}}
{{- end }}
{{- end }}


{{/* Redis URL

*/}}

{{- define "rapidpro.redisUrl" -}}
{{- if .Values.redis.enabled }}
{{- printf "redis://%s-redis-master:%v/15" ( include "rapidpro.fullname" . )  .Values.redis.service.port -}}
{{- else }}
{{- printf "%s" .Values.externalRedisUrl -}}
{{- end }}
{{- end }}

{{/* Elasticsearch URL

*/}}

{{- define "rapidpro.elasticsearchUrl" -}}
{{- if .Values.elasticsearch.enabled }}
{{- printf "http://%s-elasticsearch:%v" (include "rapidpro.fullname" . ) .Values.elasticsearch.service.port -}}
{{- else }}
{{- printf "%s" .Values.externalElasticsearchUrl -}}
{{- end }}
{{- end }}