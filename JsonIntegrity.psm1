# https://stackoverflow.com/a/17170800


Import-Module -Force "$PSScriptRoot\CommandExistance\CommandExistance.psm1"


function Get-JsonIntegrity {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)] [string] $text
    )

    if (Get-CommandExistance "Test-Json") {
        $validJson = $text | Test-Json 2>$null
    }
    else {
        try {
            ConvertFrom-Json $text -ErrorAction Stop
            $validJson = $true;
        }
        catch {
            $validJson = $false;
        }
    }

    return $validJson
}


Export-ModuleMember -Function Get-JsonIntegrity