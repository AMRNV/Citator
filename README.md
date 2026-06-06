# Citator

A browser bookmarklet that generates APA 7 or MLA citations for any webpage you're visiting. Works on any computer or Chromebook with no installs, accounts, or external services.

## Installation

1. Open `bookmarklet.html` in Chrome (or any modern browser).
2. Show the bookmarks bar: `Ctrl` + `Shift` + `B`.
3. Drag the **📎 Cite this page** button onto the bookmarks bar.
   - Alternatively: right-click the button → **Bookmark link**.

Installation is one-time. The bookmarklet works on every site from then on.

## Usage

1. Navigate to any webpage you want to cite.
2. Click **📎 Cite this page** in your bookmarks bar.
3. Choose **APA 7** or **MLA** in the panel that appears.
4. Copy the **full reference** for your bibliography, or the **in-text citation** to drop inline in your writing.
5. Click anywhere outside the panel (or ✕) to close it.

## Output examples

**APA 7 — full reference**
```
Smith, J. (2024, March 15). How the Internet Works. Mozilla Developer Network. https://developer.mozilla.org/...
```
**APA 7 — in-text**
```
(Smith, 2024)
```

**MLA — full reference**
```
Smith, John. "How the Internet Works." Mozilla Developer Network, 15 March 2024, https://developer.mozilla.org/.... Accessed 5 June 2026.
```
**MLA — in-text**
```
(Smith)
```

## Missing author fallback

| | With author | Without author |
|---|---|---|
| APA 7 full | `Smith, J. (2024). Title…` | `Title. (2024)…` |
| APA 7 in-text | `(Smith, 2024)` | `("Shortened Title…", 2024)` |
| MLA full | `Smith, John. "Title."…` | `"Title."…` |
| MLA in-text | `(Smith)` | `("Shortened Title…")` |

## How it works

The bookmarklet runs as JavaScript inside the current page, reading metadata directly from the DOM — no network requests, no proxy, no server required.

| Field | Tags checked |
|-------|-------------|
| Title | `og:title`, `<title>` |
| Author | `name="author"` |
| Site name | `og:site_name`, `name="application-name"` |
| Publish date | `article:published_time`, `name="date"`, `DC.date` |

## Compatibility

Works in Chrome, Edge, and Firefox on Windows, Mac, Linux, and Chromebook. Requires the browser to allow bookmarklets (all mainstream browsers do by default).
