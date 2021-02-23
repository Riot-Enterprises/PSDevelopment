function get-commitfiles {
    Return (git diff-index --name-only --diff-filter=ACM --cached HEAD --)    
}

function test-isbinary {
    param (
        $filename
    )
    return (git diff --no-index --numstat nul $filename).StartsWith("-`t-`t")
}