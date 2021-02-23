$TOP = git rev-parse --show-toplevel
$HOOKSPATH = (resolve-path (git config core.hookspath || Join-Path (git rev-parse --git-dir) Hooks)).Path
$ConfigFiles = (Get-ChildItem (Join-Path $HOOKSPATH 'config') -Recurse -Include '*.json').Name
foreach ($file in $ConfigFiles) {
    $Content = Get-Content (Join-Path -Path $TOP -ChildPath $file ) -ErrorAction SilentlyContinue || `
        Get-Content (Join-Path -Path $TOP -ChildPath 'config' -AdditionalChildPath $file) -ErrorAction SilentlyContinue || `
        Get-Content (Join-Path -Path $HOOKSPATH -ChildPath 'config' -AdditionalChildPath $file) -ErrorAction SilentlyContinue
    Set-Variable -Name $file.Replace('.json','') -Value ($Content | ConvertFrom-Json)
}