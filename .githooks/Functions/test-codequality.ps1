function test-codequality {
    Import-Module -Name PSScriptAnalyzer
    $output = @()
    foreach ($file in (get-commitfiles | Where-Object { $_.EndsWith('.ps1') -or $_.EndsWith('.psm1') -or $_.EndsWith('.psd1') })) {
        Write-Log -Level DEBUG -Message 'Analyzing {0}' -Arguments $file
        $output += (Invoke-ScriptAnalyzer -Path $file)
    }
    if ($output.Count -ne 0) {
        Write-Log -Level ERROR -Message  "Basic scripting errors were found in updated scripts. fix or use git commit --no-verify"
        foreach ($item in $output) {
            switch ($item.Severity) {
                'Warning' { $level='WARNING' }
                'Error' {$level = 'ERROR'}
                Default {$level = 'INFO'}
            }
            Write-Log -Level $level -Message "File: {0} - {1}" -Arguments $item.ScriptName, $item.Message
        }
        return $false
    } else {
        return $true
    }
    
}