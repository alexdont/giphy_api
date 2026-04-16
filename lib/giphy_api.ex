defmodule GiphyApi do
  @moduledoc """
  Giphy API client for searching and retrieving GIFs.

  ## Configuration

      config :giphy_api,
        api_key: "your-giphy-api-key"

  ## Usage

      # Search for GIFs
      {:ok, results} = GiphyApi.search("funny cat", limit: 20)

      # Get trending GIFs
      {:ok, results} = GiphyApi.trending(limit: 20)

  Results are returned as a list of `%GiphyApi.Gif{}` structs with
  pre-selected URLs for different sizes.
  """

  alias GiphyApi.{Client, Gif}

  @doc """
  Search for GIFs matching the query.

  ## Options

    * `:limit` - Max results (default: 20, max: 50)
    * `:offset` - Pagination offset (default: 0)
    * `:rating` - Content rating filter: "g", "pg", "pg-13", "r" (default: "pg-13")
    * `:lang` - Language code (default: "en")
  """
  @spec search(String.t(), keyword()) :: {:ok, [Gif.t()]} | {:error, term()}
  def search(query, opts \\ []) do
    Client.search(query, opts)
  end

  @doc """
  Get trending GIFs.

  ## Options

    * `:limit` - Max results (default: 20, max: 50)
    * `:offset` - Pagination offset (default: 0)
    * `:rating` - Content rating filter (default: "pg-13")
  """
  @spec trending(keyword()) :: {:ok, [Gif.t()]} | {:error, term()}
  def trending(opts \\ []) do
    Client.trending(opts)
  end

  @doc """
  Get a single GIF by its Giphy ID.
  """
  @spec get(String.t()) :: {:ok, Gif.t()} | {:error, term()}
  def get(id) do
    Client.get(id)
  end
end
