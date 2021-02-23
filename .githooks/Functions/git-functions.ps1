function get-commitfiles {
    Return (git diff-index --name-only --diff-filter=ACM --cached HEAD --)
}

function get-flowprefixes{
    (git config --list | Where-Object {
        $_.startswith('gitflow.prefix.')}).replace('gitflow.prefix.','')  | ForEach-Object {$x = $_ -split '=';@{$x[0]=$x[1]}}
}

function test-isbinary {
    param (
        $filename
    )
    return (git diff --no-index --numstat nul $filename).StartsWith("-`t-`t")
}
