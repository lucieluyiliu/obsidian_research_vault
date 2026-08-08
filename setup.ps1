# Recreate Projects\ junctions from projects.txt (or projects.local.txt if present).
# Run in PowerShell: .\setup.ps1   (junctions need no admin rights)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$dropbox = @("$env:USERPROFILE\Dropbox", "$env:USERPROFILE\Dropbox (Personal)") |
  Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $dropbox) { Write-Error "Dropbox folder not found; use absolute paths in projects.local.txt"; exit 1 }

$list = Join-Path $root "projects.txt"
if (Test-Path (Join-Path $root "projects.local.txt")) { $list = Join-Path $root "projects.local.txt" }

New-Item -ItemType Directory -Force -Path (Join-Path $root "Projects") | Out-Null
Get-Content $list | ForEach-Object {
  if ($_ -match '^\s*(#|$)') { return }
  $name, $target = $_ -split '\|', 2
  $target = ($target -replace [regex]::Escape('$DROPBOX'), $dropbox) -replace '/', '\'
  if (-not (Test-Path $target)) { Write-Warning "SKIP $name -- target not found: $target"; return }
  $link = Join-Path $root "Projects\$name"
  if (Test-Path $link) { (Get-Item $link).Delete() }
  New-Item -ItemType Junction -Path $link -Target $target | Out-Null
  Write-Host "OK   $name -> $target"
}
