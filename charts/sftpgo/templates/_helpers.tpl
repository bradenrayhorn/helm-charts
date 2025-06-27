{{/*
Expand the name of the chart.
*/}}
{{- define "sftpgo.name" -}}
{{- default "sftpgo" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sftpgo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "sftpgo" .Values.nameOverride }}
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
{{- define "sftpgo.chart" -}}
{{- printf "%s-%s" "sftpgo" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sftpgo.labels" -}}
helm.sh/chart: {{ include "sftpgo.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sftpgo.labelsServer" -}}
{{ include "sftpgo.selectorLabelsServer" . }}
{{ include "sftpgo.labels" . }}
{{- end }}

{{- define "sftpgo.labelsUI" -}}
{{ include "sftpgo.selectorLabelsUI" . }}
{{ include "sftpgo.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sftpgo.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "sftpgo.name" . }}-server
app.kubernetes.io/part-of: {{ include "sftpgo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "sftpgo.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "sftpgo.name" . }}-ui
app.kubernetes.io/part-of: {{ include "sftpgo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sftpgo.serviceAccountName" -}}
{{- default (include "sftpgo.fullname" .) .Values.serviceAccount.name }}
{{- end }}

