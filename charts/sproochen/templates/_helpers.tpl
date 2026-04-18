{{/*
Expand the name of the chart.
*/}}
{{- define "sproochen.name" -}}
{{- default "sproochen" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sproochen.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "sproochen" .Values.nameOverride }}
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
{{- define "sproochen.chart" -}}
{{- printf "%s-%s" "sproochen" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sproochen.labels" -}}
helm.sh/chart: {{ include "sproochen.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sproochen.labelsApp" -}}
{{ include "sproochen.selectorLabelsApp" . }}
{{ include "sproochen.labels" . }}
{{- end }}

{{- define "sproochen.labelsUI" -}}
{{ include "sproochen.selectorLabelsUI" . }}
{{ include "sproochen.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sproochen.selectorLabelsApp" -}}
app.kubernetes.io/name: {{ include "sproochen.name" . }}-app
app.kubernetes.io/part-of: {{ include "sproochen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "sproochen.selectorLabelsUI" -}}
app.kubernetes.io/name: {{ include "sproochen.name" . }}-ui
app.kubernetes.io/part-of: {{ include "sproochen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sproochen.serviceAccountName" -}}
{{- default (include "sproochen.fullname" .) .Values.serviceAccount.name }}
{{- end }}
