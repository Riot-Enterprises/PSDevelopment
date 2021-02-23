function test-isValidCommitMsg {
    param(
        $msgfile
    )
    if ((${commit-msg.config}) -and ${commit-msg.config}.enabled){
        $regex = '^'

        # optional revert
        if (${commit-msg.config}.revert){
            $regex+='(?<rev>revert:\s)?'
        }

        #types
        $regex+='(?<type>'
        $regex+=${commit-msg.config}.types -join '|'
        $regex+=')'

        #optional feature
        $regex+='(?:(?:\()(?<feature>\S+?)(?:\)))?'
        #:Separator
        $regex+='(?::\s+?)'
        #optional emoji
        $regex+='(?<emoji>:[\w-]+:)?'
        $regex+="(?<msg>(?!:\w+:).{$(${commit-msg.config}.length.min),$(${commit-msg.config}.length.max)})$"
        $regex
    }
    if (Select-String -Path $msgfile -Pattern $regex){
        return $true
    } else {
        return $false
    }
}