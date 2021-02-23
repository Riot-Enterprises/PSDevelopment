function get-commitfiles {
    Return (git diff-index --name-only --diff-filter=ACM --cached HEAD --)    
}
