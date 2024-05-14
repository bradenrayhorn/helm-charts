{{/*
Expand the name of the chart.
*/}}
{{- define "kanidm.name" -}}
{{- default "kanidm" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kanidm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "kanidm" .Values.nameOverride }}
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
{{- define "kanidm.chart" -}}
{{- printf "%s-%s" "kanidm" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kanidm.labels" -}}
helm.sh/chart: {{ include "kanidm.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kanidm.labelsServer" -}}
{{ include "kanidm.selectorLabelsServer" . }}
{{ include "kanidm.labels" . }}
{{- end }}

{{- define "kanidm.labelsUI" -}}
{{ include "kanidm.selectorLabelsUI" . }}
{{ include "kanidm.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kanidm.selectorLabelsServer" -}}
app.kubernetes.io/name: {{ include "kanidm.name" . }}-server
app.kubernetes.io/part-of: {{ include "kanidm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "kanidm.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "kanidm.name" . }}-ui
app.kubernetes.io/part-of: {{ include "kanidm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kanidm.serviceAccountName" -}}
{{- default (include "kanidm.fullname" .) .Values.serviceAccount.name }}
{{- end }}

