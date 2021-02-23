function test-ifmaster {
    $CURRENT_BRANCH = (git symbolic-ref HEAD)
    $MASTER_BRANCH = (git config gitflow.branch.master)
    if ($CURRENT_BRANCH.EndsWith("/$MASTER_BRANCH")) {
        Return $true
    } else {
        Return $false
    }
}