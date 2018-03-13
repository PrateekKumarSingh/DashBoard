param(
    $Search = 'powershell',
    $Count = 5,
    $order = 'date',
    $type = 'video'
)
Write-Verbose "Searching Youtube | keyword=$Search count=$Count order=$order type=$type" 

$results = python.exe  ./Youtube.py --q $Search --order $order --type $type
$youtubeObjs = foreach ($item in $results)
{
    $item | ConvertFrom-Json
}

$yt = $youtubeObjs | ForEach-Object {
    [PSCustomObject] @{
        kind             = $_.kind
        id               = $_.id
        date             = Parse-CustomDate -DateString ($_.date -replace "\.000Z", "") -DateFormat 'yyyy-MM-ddTHH:mm:ss'
        title            = $_.title
        description      = $_.description
        channelTitle     = $_.channelTitle
    }
}

$yt | Select-Object -First $Count | ft -AutoSize


python.exe .\Youtube_Analytics.py --filters="video==0LKeledvyngD"
