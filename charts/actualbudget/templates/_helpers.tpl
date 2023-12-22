{{/*
Expand the name of the chart.
*/}}
{{- define "actualbudget.name" -}}
{{- default "actualbudget" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "actualbudget.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "actualbudget" .Values.nameOverride }}
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
{{- define "actualbudget.chart" -}}
{{- printf "%s-%s" "actualbudget" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "actualbudget.labels" -}}
helm.sh/chart: {{ include "actualbudget.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "actualbudget.labelsServer" -}}
{{ include "actualbudget.selectorLabelsServer" . }}
{{ include "actualbudget.labels" . }}
{{- end }}

{{- define "actualbudget.labelsUI" -}}
{{ include "actualbudget.selectorLabelsUI" . }}
{{ include "actualbudget.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "actualbudget.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "actualbudget.name" . }}-server
app.kubernetes.io/part-of: {{ include "actualbudget.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "actualbudget.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "actualbudget.name" . }}-ui
app.kubernetes.io/part-of: {{ include "actualbudget.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "actualbudget.serviceAccountName" -}}
{{- default (include "actualbudget.fullname" .) .Values.serviceAccount.name }}
{{- end }}
