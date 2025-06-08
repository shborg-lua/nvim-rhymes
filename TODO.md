# TODO

This file outlines the development tasks required to implement **nvim-rhymes** according to the specifications in `DEV.md`.

## Core Functionality

- [ ] **Implement `rhyme.get_rhymes()`**
  - Fetch rhymes from Datamuse via `vim.fn.systemlist()`
  - Deduplicate results
  - Handle missing `curl` gracefully

- [ ] **Build `picker.open()`**
  - Integrate with `fzf-lua`
  - Display rhyme list
  - Copy selection to `+` register
  - Show notifications on success/error

- [ ] **Finalize `commands.run()`**
  - Ensure proper usage messages
  - Validate arguments
  - Wire `find` and `analyze`

- [ ] **Complete `analysis.analyze_poem()`**
  - Basic line & stanza counting
  - Naive rhyme-scheme detection
  - Placeholder for advanced analysis

## Configuration & Extensibility

- [ ] **Expose setup options**
  - `services`: list of provider IDs
  - `enable_analysis`: boolean
  - `cache_ttl`: number (seconds)
  - `api_keys`: table for auth-required services

- [ ] **Custom service registry**
  - Provide API for users to register new rhyme services
  - Document extension points in README

## Error Handling & UX

- [ ] **Network error handling**
  - Timeouts and HTTP errors
  - User notifications via `vim.notify`

- [ ] **Missing dependency fallback**
  - Detect absence of `curl`
  - Prompt user or skip gracefully

- [ ] **Debounce repeated requests**
  - Prevent spamming API when opening picker rapidly

## Caching & Rate Limits

- [ ] **In-memory caching**
  - Store recent rhyme lookups by word
  - Evict entries after `cache_ttl`

- [ ] **Rate-limiting**
  - Throttle requests based on user-configured delay

## Documentation

- [ ] **Update `doc/rhymes.txt`**
  - Add error messages and new commands
  - Document setup options

- [ ] **Enhance `README.md`**
  - Installation instructions with LazyVim / lazy.nvim
  - Configuration examples
  - Usage examples and screenshots (optional)

- [ ] **VimDoc generation**
  - Ensure `:help rhymes` works end-to-end

## Testing & CI

- [ ] **Expand Busted specs**
  - Test caching logic
  - Test error cases (network failure, missing `curl`)
  - Test configuration overrides

- [ ] **Add `luacheck`**
  - Create `.luacheckrc`
  - Enforce no globals

- [ ] **GitHub Actions workflows**
  - Run Busted on Ubuntu matrix
  - Run `luacheck`
  - Lint VimDoc (optional)

## Future Enhancements (Post-Core)

- [ ] **LSP Integration**
  - null-ls source for poem analysis
  - Code actions and diagnostics

- [ ] **Advanced AI Analysis**
  - Syllable counting, meter detection
  - AI-driven theme/tone extraction

---

*Generated on: 2025-06-08*
