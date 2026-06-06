<#
.SYNOPSIS
    Fetches a URL and generates a formatted citation.
.PARAMETER Url
    The URL of the webpage to cite.
.PARAMETER Format
    Citation format: APA7 (default) or MLA.
.EXAMPLE
    .\Get-Citation.ps1 -Url "https://example.com/article"
    .\Get-Citation.ps1 -Url "https://example.com/article" -Format MLA
#>
param(
    [string]$Url,
    [ValidateSet('APA7', 'MLA')]
    [string]$Format
)

# Interactive mode when double-clicked (no arguments)
if (-not $Url) {
    $Url = Read-Host "Enter URL"
}
if (-not $Format) {
    $choice = Read-Host "Format? [1] APA7  [2] MLA  (default: 1)"
    $Format  = if ($choice -eq '2') { 'MLA' } else { 'APA7' }
}

function Get-MetaContent($html, $name) {
    # Try name= and property= variants
    if ($html -match "(?i)<meta\s[^>]*(?:name|property)=[`"'](?:og:)?$([regex]::Escape($name))[`"'][^>]*content=[`"']([^`"']+)[`"']") {
        return $Matches[1].Trim()
    }
    if ($html -match "(?i)<meta\s[^>]*content=[`"']([^`"']+)[`"'][^>]*(?:name|property)=[`"'](?:og:)?$([regex]::Escape($name))[`"']") {
        return $Matches[1].Trim()
    }
    return $null
}

function Get-PageTitle($html) {
    # Prefer og:title, fall back to <title>
    $t = Get-MetaContent $html 'title'
    if (-not $t -and $html -match '(?i)<title[^>]*>([^<]+)</title>') {
        $t = $Matches[1].Trim()
    }
    return $t
}

function Format-AuthorAPA($author) {
    if (-not $author) { return $null }
    # If "First Last", convert to "Last, F."
    $parts = $author.Trim() -split '\s+'
    if ($parts.Count -ge 2) {
        $last  = $parts[-1]
        $inits = ($parts[0..($parts.Count - 2)] | ForEach-Object { "$($_[0])." }) -join ' '
        return "$last, $inits"
    }
    return $author
}

function Format-AuthorMLA($author) {
    if (-not $author) { return $null }
    $parts = $author.Trim() -split '\s+'
    if ($parts.Count -ge 2) {
        $last  = $parts[-1]
        $first = $parts[0..($parts.Count - 2)] -join ' '
        return "$last, $first"
    }
    return $author
}

function Parse-Date($raw) {
    if (-not $raw) { return $null }
    try { return [datetime]::Parse($raw) } catch { return $null }
}

# ── Fetch the page ────────────────────────────────────────────────────────────
try {
    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -ErrorAction Stop
    $html     = $response.Content
} catch {
    Write-Error "Could not fetch URL: $_"
    exit 1
}

# ── Extract metadata ──────────────────────────────────────────────────────────
$title      = Get-PageTitle $html
$author     = Get-MetaContent $html 'author'
$siteName   = Get-MetaContent $html 'site_name'
$dateRaw    = Get-MetaContent $html 'article:published_time'
if (-not $dateRaw) { $dateRaw = Get-MetaContent $html 'published_time' }
if (-not $dateRaw) { $dateRaw = Get-MetaContent $html 'date' }

$parsedDate = Parse-Date $dateRaw
$accessed   = Get-Date

# Decode common HTML entities in title/author
foreach ($var in 'title','author','siteName') {
    $val = (Get-Variable $var).Value
    if ($val) {
        $val = $val -replace '&amp;','&' -replace '&lt;','<' -replace '&gt;','>' `
                    -replace '&quot;','"' -replace '&#39;',"'" -replace '&nbsp;',' '
        Set-Variable $var $val
    }
}

# ── Build citation ────────────────────────────────────────────────────────────
switch ($Format) {

    'APA7' {
        $parts = @()

        $authorStr = Format-AuthorAPA $author
        if ($authorStr) { $parts += $authorStr }

        if ($parsedDate) {
            $parts += "($($parsedDate.Year), $($parsedDate.ToString('MMMM d')))"
        } else {
            $parts += '(n.d.)'
        }

        if ($title)    { $parts += "*$title*" }
        if ($siteName) { $parts += $siteName }

        $citation  = ($parts -join '. ').TrimEnd('.')
        $citation += ". $Url"
    }

    'MLA' {
        $authorStr = Format-AuthorMLA $author
        $citation  = ''

        if ($authorStr) { $citation += "$authorStr. " }
        if ($title)     { $citation += "`"$title.`" " }
        if ($siteName)  { $citation += "*$siteName*, " }

        if ($parsedDate) {
            $citation += $parsedDate.ToString('d MMMM yyyy') + ', '
        }

        $accessedStr = $accessed.ToString('d MMMM yyyy')
        $citation    += "$Url. Accessed $accessedStr."
    }
}

Write-Output ""
Write-Output $citation
Write-Output ""

# Keep window open when double-clicked
if ($Host.Name -eq 'ConsoleHost' -and -not [Environment]::GetCommandLineArgs().Contains('-NonInteractive')) {
    Read-Host "Press Enter to close"
}
