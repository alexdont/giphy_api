# Changelog

## 0.1.1

### Features

- All public functions (`search/2`, `trending/1`, `get/2`) now accept an
  `:api_key` option to override the Giphy API key per-call. The existing
  `Application.get_env(:giphy_api, :api_key)` config remains the default.
  Intended for apps that store the key outside app env (e.g. per-tenant DB
  settings). `get/1` is now `get/2` with a defaulted opts list.

## 0.1.0

### Initial release

- `GiphyApi.search/2` - Search for GIFs
- `GiphyApi.trending/1` - Get trending GIFs
- `GiphyApi.get/1` - Get a single GIF by ID
- `GiphyApi.Gif` struct with pre-selected URLs for preview, original, and downsized sizes
