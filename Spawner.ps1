[cmdletbinding()]
param()

. "$PSScriptRoot\utils\Functions.ps1"
. "$PSScriptRoot\Get-TopTrendingGithubRepos.ps1" 'weekly'
. "$PSScriptRoot\Get-TopSubReddits.ps1"
