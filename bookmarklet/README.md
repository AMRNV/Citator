# Citator — Bookmarklet

A browser bookmarklet that generates APA 7 or MLA citations for the page you are currently viewing. Works on any computer or Chromebook with no installs, accounts, or external services.

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

## How it works

The bookmarklet runs as JavaScript inside the current page, reading metadata directly from the DOM — no network requests, no proxy, no server required.

| Field | Tags checked |
|-------|-------------|
| Title | `og:title`, `<title>` |
| Author | `name="author"` |
| Site name | `og:site_name`, `name="application-name"` |
| Publish date | `article:published_time`, `name="date"`, `DC.date` |

## In-text citations

| Format | Output | When no author |
|--------|--------|----------------|
| APA 7  | `(Last, Year)` or `(Last, n.d.)` | `(n.d.)` |
| MLA    | `(Last)` | Shortened title in quotes, e.g. `("How the Internet...")` |

## Compatibility

Works in Chrome, Edge, and Firefox on Windows, Mac, Linux, and Chromebook. Requires the browser to allow bookmarklets (all mainstream browsers do by default).
