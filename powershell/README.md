# Citator — PowerShell

A PowerShell script that fetches a URL and outputs an APA 7 or MLA citation to the terminal.

## Requirements

- Windows 10 or 11 (PowerShell 5.1 included)
- Internet access

## Usage

### Double-click

Double-click `Get-Citation.bat`. You will be prompted for a URL and citation format. The window stays open until you press Enter.

### Command line

```powershell
# APA 7 (default)
.\Get-Citation.ps1 -Url "https://example.com/article"

# MLA
.\Get-Citation.ps1 -Url "https://example.com/article" -Format MLA
```

## Files

| File | Purpose |
|------|---------|
| `Get-Citation.ps1` | Main script |
| `Get-Citation.bat` | Double-click launcher — bypasses execution policy with `-ExecutionPolicy Bypass` so the script runs on any Windows PC without configuration |

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

The script fetches the page with `Invoke-WebRequest` and reads standard `<meta>` tags for title, author, site name, and publish date. Missing fields are handled gracefully.
