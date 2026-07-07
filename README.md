# Ribhu Ratnam's Website

A Hugo-based personal website hosted at [ribhu.in](https://ribhu.in/).

## Quick Start

### Prerequisites
- [Hugo Extended](https://gohugo.io/installation/) v0.120+
- Git

### Clone with Submodules
```bash
git clone --recurse-submodules git@github.com:ribhuji/website.git
cd website
```

If already cloned:
```bash
git submodule update --init --recursive
```

### Development
```bash
cd ribhu
hugo server -t etch --buildFuture
```
Site available at `http://localhost:1313/`

### Production Build
```bash
cd ribhu
hugo --minify -t etch --buildFuture
```
Output goes to `ribhu/public/` (git submodule)

### Deploy
```bash
cd ribhu/public
git add -A
git commit -m "Rebuild: description"
git push origin HEAD:main
```

## File Structure

```
website/
├── .gitmodules              # Submodule configuration
├── README.md                # This file
└── ribhu/                   # Hugo project root
    ├── .gitignore
    ├── config.toml          # Hugo configuration
    ├── archetypes/          # Content templates
    ├── content/             # Site content
    │   ├── _index.md        # Homepage
    │   ├── about/           # About page
    │   └── posts/           # Blog posts
    ├── layouts/             # Template overrides
    │   └── partials/
    │       ├── footer.html  # Custom footer with dynamic year
    │       └── head.html    # Custom head with KaTeX support
    ├── static/              # Static assets
    │   └── images/          # Images (copied to public/)
    ├── themes/
    │   └── etch/            # Git submodule: github.com/LukasJoswiak/etch
    └── public/              # Git submodule: github.com/ribhuji/ribhuji.github.io
         └── (generated site - do not edit directly)
```

## Submodules

### `ribhu/themes/etch`
- **Source**: https://github.com/LukasJoswiak/etch
- **Purpose**: Hugo theme (layout, styling, partials)
- **Updates**: `git submodule update --remote ribhu/themes/etch`

### `ribhu/public`
- **Source**: https://github.com/ribhuji/ribhuji.github.io
- **Purpose**: GitHub Pages deployment target
- **Workflow**: Hugo builds → commits to submodule → push to deploy
- **Never edit directly** - always rebuild from `ribhu/` source

## Key Configuration

### `ribhu/config.toml`
```toml
baseURL = "https://ribhu.in/"
theme = "etch"
# Copyright uses dynamic year via template override
```

### Custom Template Overrides
- `layouts/partials/footer.html` - Uses `{{ now.Year }}` for auto-updating copyright
- `layouts/partials/head.html` - Conditionally loads KaTeX for math rendering

## Content

Blog posts in `content/posts/` use TOML front matter:
```toml
+++
title = 'Post Title'
date = 2024-03-09T14:40:43+05:30
draft = false
+++
```

Future-dated posts require `--buildFuture` flag to render.

## Math Support

KaTeX loads automatically on pages containing `$...$` or `$$...$$` delimiters.

## Images

Place images in `static/images/` - they're copied to `public/images/` on build.
Reference in markdown: `![Alt](/images/filename.png)`

## Theme Customization

Override theme templates by creating matching paths in `layouts/`:
- `layouts/partials/footer.html` → overrides theme's footer
- `layouts/partials/head.html` → overrides theme's head

## Useful Commands

```bash
# Update theme submodule
git submodule update --remote ribhu/themes/etch

# Clean build
cd ribhu && rm -rf public/* && hugo --minify -t etch --buildFuture

# Check submodule status
git submodule status

# List all Hugo pages
cd ribhu && hugo list all
```