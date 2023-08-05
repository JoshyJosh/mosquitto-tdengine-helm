{{/*
Expand the name of the chart.
*/}}
{{- define "mqtt-tsdb-adapter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mqtt-tsdb-adapter.fullname" -}}
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
{{- define "mqtt-tsdb-adapter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mqtt-tsdb-adapter.labels" -}}
helm.sh/chart: {{ include "mqtt-tsdb-adapter.chart" . }}
{{ include "mqtt-tsdb-adapter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mqtt-tsdb-adapter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mqtt-tsdb-adapter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mqtt-tsdb-adapter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mqtt-tsdb-adapter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the service names for services
*/}}
{{- define "mqtt-tsdb-adapter.servicePort" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "mqttTsdbAdapterPort") }}
{{- .Values.global.common.mqttTsdbAdapterPort }}
{{- else }}
{{- .Values.service.ports.mqtt }}
{{- end }}
{{- end }}

{{/*
Create the service names for healthcheck ports
*/}}
{{- define "mqtt-tsdb-adapter.healthcheckPort" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "mqttTSDBAdapter") (hasKey .Values.global.mqttTSDBAdapter "healthcheckPort") }}
{{- .Values.global.mqttTSDBAdapter.healthcheckPort }}
{{- else }}
{{- .Values.service.ports.healthcheck }}
{{- end }}
{{- end }}


{{/*
Create the service names for services
*/}}
{{- define "mqtt-tsdb-adapter.mosquittoPort" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "ports") (hasKey .Values.global.ports "mqtt") }}
{{- .Values.global.ports.mqtt }}
{{- else }}
{{- .Values.service.ports.mqtt }}
{{- end }}
{{- end }}


{{/*
Create the service names for services
*/}}
{{- define "mqtt-tsdb-adapter.tdenginePort" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "tdenginePort") }}
{{- .Values.global.tdenginePort }}
{{- else }}
{{- .Values.service.ports.tdengine }}
{{- end }}
{{- end }}
