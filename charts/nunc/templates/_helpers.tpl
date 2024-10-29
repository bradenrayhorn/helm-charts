{{/*
Expand the name of the chart.
*/}}
{{- define "nunc.name" -}}
{{- default "nunc" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nunc.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "nunc" .Values.nameOverride }}
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
{{- define "nunc.chart" -}}
{{- printf "%s-%s" "nunc" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nunc.labels" -}}
helm.sh/chart: {{ include "nunc.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "nunc.labelsServer" -}}
{{ include "nunc.selectorLabelsServer" . }}
{{ include "nunc.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nunc.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "nunc.name" . }}-server
app.kubernetes.io/part-of: {{ include "nunc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nunc.serviceAccountName" -}}
{{- default (include "nunc.fullname" .) .Values.serviceAccount.name }}
{{- end }}
