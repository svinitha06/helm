{{- define "backdeploy.name1" -}}
{{- if .Values.back.deploymentname }}
{{- printf "%s" .Values.back.deploymentname -}}
{{- else }}
{{ print .Release.Name }}
{{- end -}}
{{- end -}}

{{- define "backdeploy.name" -}}
labels:
  app: backdeployment
{{- end -}}


{{- define "frontpod" -}}
name: {{ .Values.front.podname }}
labels:
  app: {{ .Values.front.podlabel }}
{{- end -}}












{{/*
Expand the name of the chart.
*/}}
{{- define "helmdemo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helmdemo.fullname" -}}
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
{{- define "helmdemo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helmdemo.labels" -}}
helm.sh/chart: {{ include "helmdemo.chart" . }}
{{ include "helmdemo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helmdemo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helmdemo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "helmdemo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "helmdemo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
