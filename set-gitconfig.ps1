Add-LoggingTarget -Name Console
cls
# Load Support Scripts
Write-Log -Level INFO -Message 'Running {0}' -Arguments 'Set-GitConfig'
Write-Log -Level INFO -Message "Current Hooks Path: {0}" -Arguments (resolve-path (git config core.hookspath || Join-Path (git rev-parse --git-dir) Hooks)).Path
$HOOKSPATH = Join-Path $PSScriptRoot '.githooks'
Write-Log -Level INFO -Message 'HooksPath {0}' -Arguments $HOOKSPATH
git config core.hookspath $HOOKSPATH
Write-Log -Level INFO -Message "Configured Hooks Path: {0}" -Arguments (resolve-path (git config core.hookspath || Join-Path (git rev-parse --git-dir) Hooks)).Path
Wait-Logging