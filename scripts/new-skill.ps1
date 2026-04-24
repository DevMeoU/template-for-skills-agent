<#
.SYNOPSIS
  Create a new Agent Skill from the template-skill skeleton.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File ./scripts/new-skill.ps1 -Name supervisor-agents -Output ./dist
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$Name,

  [string]$Output = '.',

  [string]$Title,

  [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function To-SkillName([string]$Value) {
  $s = $Value.ToLowerInvariant() -replace '[^a-z0-9]+','-'
  $s = $s.Trim('-')
  if ([string]::IsNullOrWhiteSpace($s)) { throw 'Skill name cannot be empty after normalization.' }
  if ($s.Length -gt 64) { $s = $s.Substring(0,64).Trim('-') }
  return $s
}

$skillName = To-SkillName $Name
if (-not $Title) {
  $Title = ($skillName -split '-' | ForEach-Object { if ($_.Length -gt 0) { $_.Substring(0,1).ToUpperInvariant() + $_.Substring(1) } }) -join ' '
}

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$template = Join-Path $repoRoot 'template-skill'
$destRoot = Resolve-Path -LiteralPath $Output -ErrorAction SilentlyContinue
if (-not $destRoot) {
  New-Item -ItemType Directory -Force -Path $Output | Out-Null
  $destRoot = Resolve-Path -LiteralPath $Output
}
$dest = Join-Path $destRoot $skillName

if ((Test-Path -LiteralPath $dest) -and -not $Force) {
  throw "Destination already exists: $dest. Use -Force to overwrite."
}

if (Test-Path -LiteralPath $dest) { Remove-Item -LiteralPath $dest -Recurse -Force }
Copy-Item -LiteralPath $template -Destination $dest -Recurse -Force

$skillFile = Join-Path $dest 'SKILL.md'
$content = Get-Content -LiteralPath $skillFile -Raw
$content = $content.Replace('name: template-skill', "name: $skillName")
$content = $content.Replace('# Template Skill title', "# $Title")
Set-Content -LiteralPath $skillFile -Value $content -Encoding UTF8

Write-Host "Created skill: $dest" -ForegroundColor Green
Write-Host "Next: edit SKILL.md description, workflow, output format, and dependencies." -ForegroundColor Cyan
