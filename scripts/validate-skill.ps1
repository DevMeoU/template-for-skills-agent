<#
.SYNOPSIS
  Lightweight validator for Anthropic-style Agent Skill folders.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File ./scripts/validate-skill.ps1 ./template-skill
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true, Position=0)]
  [string]$Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$skillDir = Resolve-Path -LiteralPath $Path
$skillFile = Join-Path $skillDir 'SKILL.md'
if (-not (Test-Path -LiteralPath $skillFile)) { throw "Missing SKILL.md: $skillFile" }

$text = Get-Content -LiteralPath $skillFile -Raw
if ($text -notmatch '(?s)^---\s*(.*?)\s*---') { throw 'Missing YAML frontmatter delimited by ---' }
$fm = $Matches[1]

$name = ($fm -split "`n" | Where-Object { $_ -match '^name:\s*(.+)$' } | ForEach-Object { $Matches[1].Trim().Trim('"') } | Select-Object -First 1)
$description = ($fm -split "`n" | Where-Object { $_ -match '^description:\s*(.+)$' } | ForEach-Object { $Matches[1].Trim() } | Select-Object -First 1)

if (-not $name) { throw 'Frontmatter missing required field: name' }
if ($name -notmatch '^[a-z0-9][a-z0-9-]{0,63}$') { throw "Invalid skill name '$name'. Use lowercase letters, digits, and hyphens only, max 64 chars." }
if (-not $description) { throw 'Frontmatter missing required field: description' }
if ($description.Length -lt 80) { throw 'Description looks too short. Include what it does and trigger contexts.' }
if ($text -notmatch '(?m)^#\s+') { throw 'Missing top-level # title' }

$forbidden = @('README.md','CHANGELOG.md','INSTALLATION_GUIDE.md','QUICK_REFERENCE.md')
foreach ($file in $forbidden) {
  if (Test-Path -LiteralPath (Join-Path $skillDir $file)) { throw "Avoid extra documentation in skill folder: $file" }
}

Write-Host "Skill looks valid: $skillDir" -ForegroundColor Green
