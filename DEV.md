# nvim-rhymes Project Requirements

## 1. Lazy-loading

- Define a single `:Rhymes` user command
  - Subcommands: `find <word>`, `analyze`
- No startup overhead (load only on command)

## 2. Zero Plenary Dependency

- Use `vim.fn.systemlist()` for HTTP requests
- Avoid `plenary.job` and any deprecated APIs

## 3. Rhyme Picker

- Integrate with **fzf-lua**
- Display list of rhymes; copy selection to `"+` register

## 4. Configurable Rhyme Services

- Default: **Datamuse API**
- Easy extension point for additional providers (e.g., RhymeBrain, AI-based)

## 5. Poem Analysis (Optional)

- Stubbed in `analysis.lua`
- Toggle via `enable_analysis` in `setup()`
- Hook into **null-ls** for future LSP-based checks

## 6. Tests with Busted

- Place specs under `spec/`
- Use pure **Busted** + LuaRocks (no plenary test harness)

## 7. Documentation

- VimDoc file: `doc/rhymes.txt` (for `:help rhymes`)
- Markdown `README.md` covering installation, config, and usage
