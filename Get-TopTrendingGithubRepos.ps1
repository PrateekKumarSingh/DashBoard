param(
    $Duration = 'Today',
    $Count = 5
)
Write-Verbose "Fetching popular GitHub repositories" 
$Github  = Invoke-Expression -Command "python.exe c:/Data/Powershell/Scripts/Dashboard/Get-GithubTrends.py $Duration"
$all = Foreach($repo in $Github){
    [pscustomobject](Convert-PythonDictionaryToPowershellHashTable $repo)
}

$all | Select-Object repo,stars*,*count, d* -First $Count | ft -AutoSize
