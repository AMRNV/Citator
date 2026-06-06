# Citator — HTML

A standalone web page that generates APA 7 or MLA citations from a URL.

## Requirements

- A modern browser (Chrome, Edge, Firefox)
- Internet access (uses [allorigins.win](https://api.allorigins.win) to bypass CORS)

## Usage

Open `Citator.html` in your browser, paste a URL, choose a format, and click **Generate citation**. Use the **Copy** button to copy the result to the clipboard.

## How it works

The page sends the target URL through a CORS proxy, parses the returned HTML for metadata, and builds the citation from whatever it finds.

| Field | Tags checked |
|-------|-------------|
| Title | `og:title`, `<title>` |
| Author | `name="author"` |
| Site name | `og:site_name` |
| Publish date | `article:published_time`, `name="date"` |

Missing fields are handled gracefully — author is omitted if absent, date falls back to `n.d.` in APA or is omitted in MLA.

## Error messages

| Message | Cause |
|---------|-------|
| Network error | No internet connection |
| Page not found (404) | Bad URL |
| Access denied (403) | Site blocked the request |
| Too many requests (429) | Rate limited — wait and retry |
| Request timed out | Site took too long to respond |
| Page returned no content | Login wall or bot protection |
