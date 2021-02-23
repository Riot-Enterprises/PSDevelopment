

function test-ifmerge-marker-commits {
    $MERGE_FILES = ""
    foreach ($file in get-commitfiles) {
        if (Select-String -Path $file -Pattern '^<<<<<<< |^>>>>>>> ') {
            if (!(test-isbinary)) {
                $MERGE_FILES = "`n`t$file"
            } 
        }
    }
    if ($MERGE_FILES) {
        Write-Log -Level ERROR -Message 'Merge Conflicts found {0}' -Arguments $MERGE_FILES
        Return $true
    }
    else {
        Return $false
    }
}