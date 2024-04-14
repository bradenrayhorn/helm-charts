{{/*
Expand the name of the chart.
*/}}
{{- define "uptimekuma.name" -}}
{{- default "uptimekuma" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "uptimekuma.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "uptimekuma" .Values.nameOverride }}
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
{{- define "uptimekuma.chart" -}}
{{- printf "%s-%s" "uptimekuma" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "uptimekuma.labels" -}}
helm.sh/chart: {{ include "uptimekuma.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "uptimekuma.labelsServer" -}}
{{ include "uptimekuma.selectorLabelsServer" . }}
{{ include "uptimekuma.labels" . }}
{{- end }}

{{- define "uptimekuma.labelsUI" -}}
{{ include "uptimekuma.selectorLabelsUI" . }}
{{ include "uptimekuma.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "uptimekuma.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "uptimekuma.name" . }}-server
app.kubernetes.io/part-of: {{ include "uptimekuma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "uptimekuma.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "uptimekuma.name" . }}-ui
app.kubernetes.io/part-of: {{ include "uptimekuma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "uptimekuma.serviceAccountName" -}}
{{- default (include "uptimekuma.fullname" .) .Values.serviceAccount.name }}
{{- end }}
