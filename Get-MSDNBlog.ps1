param(
    $Blog = 'powershell',
    $Count
)

Write-Verbose "Fetch articles from $blog team blog"

$article = @()
$pages = [math]::Ceiling($Count/10)


1..$pages | ForEach-Object {
    $xml = [xml] ((Invoke-WebRequest "https://blogs.msdn.microsoft.com/$Blog/feed/?paged=$_").content)
    if($xml){
        Foreach ($item in $xml.rss.channel.item)
        {    
            $date = Parse-CustomDate -DateString $($item.pubDate -replace " \+0000", "").trim() -DateFormat 'ddd, d MMM yyyy HH:mm:ss'
            try{
                $article += [PSCustomObject] @{
                    date         = $date
                    author       = $item.creator.'#cdata-section'
                    title        = $item.title
                    num_comments = ($item.comments)[1]
                    link         = $item.link
                    category     = $item.category.'#cdata-section'#.where({$_ -ne 'Uncategorized'})
                    description  = $item.description.'#cdata-section'
                    commentsURL  = ($item.comments)[0]
                }
            }
            catch{
                $_.exception.message
            }
        }
    }

}

$article | Select-Object -First $Count | ft -AutoSize   
