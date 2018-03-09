Write-Verbose "Loading Utility Functions"
function TrimStartChar ($String)
{
    #, [char[]]$CharsToReplace) {
    $string[1..($string.Length - 1)] -join ""
    #(([char[]] $string) | Where-Object {$_ -notin $charsToReplace} ) -join ''
}
function TrimEndChar ($String)
{
    #, [char[]]$CharsToReplace) {
    $string[0..($string.Length - 2)] -join ""
    #(([char[]] $string) | Where-Object {$_ -notin $charsToReplace} ) -join ''
}
Function Convert-PythonDictionaryToPowershellHashTable ($DictionaryAsString)
{
    $hash = @{}
    
    $DictionaryAsString = TrimEndChar (TrimEndChar(TrimStartChar (TrimStartChar -String $DictionaryAsString)))
    foreach ($item in $DictionaryAsString -replace "', '", "@@" -split "@@" )
    {
        
        $key, $value = $item -replace "': '", "@@" -split "@@" #| ForEach-Object {$_[2]}
        #$key = $key[1..($key.Length-1)] -join ''
        #$value = $value[0..($value.Length-2)] -join ''
        $hash.Add($key, $value)
    }
    
    $hash
}
