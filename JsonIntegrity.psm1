# https://stackoverflow.com/a/17170800


Import-Module -Force "$PSScriptRoot\CommandExistance\CommandExistance.psm1"


function Get-JsonIntegrity {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)] [AllowEmptyString()] [string] $text
    )

    if ([string]::IsNullOrEmpty($text)) {
        $validJson = $false
    }
    else {
        # Use the cmdlet Test-Json ONLY if present AND if powershell version is greater than 7.3.0
        # pwsh versions prior to 7.3.0 do not recognize arrays and primitives as valid json, incorrectly
        # See this issue: https://github.com/PowerShell/PowerShell/issues/11384
        if ((Get-CommandExistance "Test-Json") -and ($host.Version.Major -ge 7) -and ($host.Version.Minor -ge 3)) {
            $validJson = $text | Test-Json 2>$null
        }
        else {
            try {
                ConvertFrom-Json $text -ErrorAction Stop >$null
                $validJson = $true;
            }
            catch {
                $validJson = $false;
            }
        }
    }

    return $validJson
}


Export-ModuleMember -Function Get-JsonIntegrity