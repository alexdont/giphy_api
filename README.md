# GiphyApi

Standalone Elixir client for the [Giphy API](https://developers.giphy.com/). Search, trending, and single GIF lookup with typed structs.

## Installation

Add `giphy_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:giphy_api, "~> 0.1.0"}
  ]
end
```

## Configuration

```elixir
# config/runtime.exs
config :giphy_api, api_key: System.get_env("GIPHY_API_KEY")
```

Get your API key at [developers.giphy.com](https://developers.giphy.com/).

## Usage

### Search

```elixir
{:ok, gifs} = GiphyApi.search("funny cat")

# With options
{:ok, gifs} = GiphyApi.search("funny cat", limit: 10, rating: "g", lang: "en")
```

### Trending

```elixir
{:ok, gifs} = GiphyApi.trending(limit: 20)
```

### Get by ID

```elixir
{:ok, gif} = GiphyApi.get("xT9IgzoKnwFNmISR8I")
```

### Response

All functions return `{:ok, result}` or `{:error, reason}`. Results are `%GiphyApi.Gif{}` structs:

```elixir
%GiphyApi.Gif{
  id: "xT9IgzoKnwFNmISR8I",
  title: "Funny Cat GIF",
  url: "https://giphy.com/gifs/...",
  preview_url: "https://media.giphy.com/.../200w.gif",
  preview_width: 200,
  preview_height: 150,
  original_url: "https://media.giphy.com/.../giphy.gif",
  original_width: 480,
  original_height: 360,
  downsized_url: "https://media.giphy.com/.../giphy-downsized-medium.gif",
  username: "catgifs"
}
```

### Per-call API key

All functions accept an `:api_key` option that overrides the app config. Useful for per-tenant setups where the key is stored in a database rather than app env:

```elixir
{:ok, gifs} = GiphyApi.search("funny cat", api_key: "per-tenant-key", limit: 10)
```

### Options

| Option | Default | Description |
|--------|---------|-------------|
| `:api_key` | app config | Override Giphy API key for this call |
| `:limit` | 20 | Max results (up to 50) |
| `:offset` | 0 | Pagination offset |
| `:rating` | `"pg-13"` | Content filter: `"g"`, `"pg"`, `"pg-13"`, `"r"` |
| `:lang` | `"en"` | Language code (search only) |

## License

MIT
