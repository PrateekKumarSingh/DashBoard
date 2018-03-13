[cmdletbinding()]
param()

. "$PSScriptRoot\utils\Functions.ps1"
. "$PSScriptRoot\Get-TopTrendingGithubRepos.ps1" 'today' 10
. "$PSScriptRoot\Get-TopTrendingGithubRepos.ps1" 'weekly' 10
. "$PSScriptRoot\Get-TopSubReddits.ps1" 'powershell' 10
. "$PSScriptRoot\Get-TopTweets.ps1" '#powershell' 10
. "$PSScriptRoot\Get-MSDNBlog.ps1" 'Powershell' 10
. "$PSScriptRoot\Get-Youtube.ps1" 'Powershell' 10 'date' 'video'
. "$PSScriptRoot\Get-Youtube.ps1" 'Powershell' 10 'date' 'channel'
. "$PSScriptRoot\Get-Youtube.ps1" 'Powershell' 10 'date' 'playlist'



Install-Module UniversalDashboard
