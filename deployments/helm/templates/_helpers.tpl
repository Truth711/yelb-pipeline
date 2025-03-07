{{/*
Expand the name of the chart.
*/}}

{{- define "yelb.ui.name" -}}
ui
{{- end }}

{{- define "yelb.ui.fullname" -}}
{{ .Release.Name }}-ui
{{- end }}

{{- define "yelb.appserver.name" -}}
appserver
{{- end }}

{{- define "yelb.appserver.fullname" -}}
{{ .Release.Name }}-appserver
{{- end }}

{{- define "yelb.db.name" -}}
db
{{- end }}

{{- define "yelb.db.fullname" -}}
{{ .Release.Name }}-db
{{- end }}

{{- define "redis.name" -}}
redis
{{- end }}

{{- define "redis.fullname" -}}
{{ .Release.Name }}-redis
{{- end }}

{{- define "yelb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "yelb.fullname" -}}
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
{{- define "yelb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "yelb.labels" -}}
helm.sh/chart: {{ include "yelb.chart" . }}
{{ include "yelb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "yelb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "yelb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "yelb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "yelb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
