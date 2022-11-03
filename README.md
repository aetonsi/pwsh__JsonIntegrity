# pwsh__JsonIntegrity
Powershell util to check whether a given string is valid JSON.

# Usage
```powershell
# import module first
Import-Module ./JsonIntegrity.psm1

# use the imported function
$validJson = Get-JsonIntegrity "[1,2,3]" # True
$validJson = Get-JsonIntegrity "asdasdasd" # False
```
