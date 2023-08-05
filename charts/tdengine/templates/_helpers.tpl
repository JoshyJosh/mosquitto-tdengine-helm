{{/*
Expand the name of the chart.
*/}}
{{- define "tdengine.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tdengine.fullname" -}}
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
{{- define "tdengine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tdengine.labels" -}}
helm.sh/chart: {{ include "tdengine.chart" . }}
{{ include "tdengine.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tdengine.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tdengine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tdengine.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tdengine.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the service names for services
*/}}
{{- define "tdengine.serviceTCPPorts" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "common") (hasKey .Values.global.common "mosquittoPort") }}
{{- .Values.global.common.serviceTCPPorts }}
{{- else }}
{{- .Values.service.ports.mqtt }}
{{- end }}
{{- end }}

{{- define "tdengine.serviceUDPPorts" -}}
{{- if and (hasKey .Values "global") (hasKey .Values.global "common") (hasKey .Values.global.common "mosquittoPort") }}
{{- .Values.global.common.serviceUDPPorts }}
{{- else }}
{{- .Values.service.ports.mqtt }}
{{- end }}
{{- end }}