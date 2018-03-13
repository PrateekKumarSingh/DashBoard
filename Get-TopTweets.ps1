param(
    $Search = '#powershell',
    $Count = 5
)
Write-Verbose "Fetching popular Tweets" 
$configs = @{}
Get-Content ./utils/configurations.txt | ForEach-Object {
    $key, $value = $_.split('=')
    $configs[$key]=$value
}


$SearchedTweets = python.exe  $PSScriptRoot/Twitter.py $Search $configs['consumer_key'] $configs['consumer_secret'] $configs['token'] $configs['token_secret']
$tweetObjs = foreach($item in $SearchedTweets){
    $item | ConvertFrom-Json
}

$tweets = $tweetObjs | ForEach-Object {
    [PSCustomObject] @{
        id = $_.id
        screen_name = $_.user.screen_name
        date = Parse-CustomDate -DateString ($_.created_at -replace " \+0000", "")
        retweet_count = $_.retweet_count
        favorite_count = $_.favorite_count
        text = $_.text
        url = "https://twitter.com/$($_.user.screen_name)/status/$($_.id)"
        user = [PSCustomObject] @{
                    name = $_.user.name
                    screen_name = $_.user.screen_name
                    description = $_.user.description
                    profile_image_url = $_.user.profile_image_url
                    followers_count = $_.user.followers_count
                    friends_count = $_.user.friends_count   
                    favourites_count = $_.user.favourites_count
                    statuses_count = $_.user.statuses_count
               }
        retweeted_status = $_.retweeted_status
        sensitive = $_.possibly_sensitive
    }
}

$tweets | Sort-Object date -Descending `
           | Where-Object {(-not $_.retweeted_status) -and $_.date -gt (get-date).AddDays(-1)} `
           | Sort-Object  retweet_count, favorite_count -Descending `
           | Select-Object -First $Count | ft -AutoSize


