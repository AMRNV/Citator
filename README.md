# Citator

Generate APA 7 or MLA citations from a URL.

## Usage

### Double-click (any Windows PC)

Double-click `Get-Citation.bat`. You will be prompted for a URL and citation format.

### Command line

```powershell
# APA 7 (default)
.\Get-Citation.ps1 -Url "https://example.com/article"

# MLA
.\Get-Citation.ps1 -Url "https://example.com/article" -Format MLA
```

## Output examples

**APA 7**
```
Smith, J. (2024, March 15). *How the Internet Works*. Mozilla Developer Network. https://developer.mozilla.org/...
```

**MLA**
```
Smith, John. "How the Internet Works." *Mozilla Developer Network*, 15 March 2024, https://developer.mozilla.org/.... Accessed 5 June 2026.
```

## How it works

The script fetches the page and reads standard `<meta>` tags to extract:

| Field | Tags checked |
|-------|-------------|
| Title | `og:title`, `<title>` |
| Author | `name="author"` |
| Site name | `og:site_name` |
| Publish date | `article:published_time`, `name="date"` |

Missing fields are handled gracefully — author is omitted if absent, date falls back to `n.d.` in APA or is omitted in MLA.

## Requirements

- Windows with PowerShell 5.1 or later (included in Windows 10/11)
- Internet access to fetch the target URL
