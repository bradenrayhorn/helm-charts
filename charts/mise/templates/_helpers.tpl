{{/*
Expand the name of the chart.
*/}}
{{- define "mise.name" -}}
{{- default "mise" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mise.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "mise" .Values.nameOverride }}
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
{{- define "mise.chart" -}}
{{- printf "%s-%s" "mise" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mise.labels" -}}
helm.sh/chart: {{ include "mise.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "mise.labelsServer" -}}
{{ include "mise.selectorLabelsServer" . }}
{{ include "mise.labels" . }}
{{- end }}

{{- define "mise.labelsUI" -}}
{{ include "mise.selectorLabelsUI" . }}
{{ include "mise.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mise.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "mise.name" . }}-server
app.kubernetes.io/part-of: {{ include "mise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "mise.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "mise.name" . }}-ui
app.kubernetes.io/part-of: {{ include "mise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mise.serviceAccountName" -}}
{{- default (include "mise.fullname" .) .Values.serviceAccount.name }}
{{- end }}

