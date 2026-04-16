defmodule GiphyApi.Client do
  @moduledoc false

  alias GiphyApi.Gif

  @base_url "https://api.giphy.com/v1/gifs"

  def search(query, opts) do
    params = %{
      q: query,
      limit: Keyword.get(opts, :limit, 20),
      offset: Keyword.get(opts, :offset, 0),
      rating: Keyword.get(opts, :rating, "pg-13"),
      lang: Keyword.get(opts, :lang, "en")
    }

    case get_request("#{@base_url}/search", params) do
      {:ok, %{"data" => data}} -> {:ok, Enum.map(data, &Gif.from_api/1)}
      {:error, _} = error -> error
    end
  end

  def trending(opts) do
    params = %{
      limit: Keyword.get(opts, :limit, 20),
      offset: Keyword.get(opts, :offset, 0),
      rating: Keyword.get(opts, :rating, "pg-13")
    }

    case get_request("#{@base_url}/trending", params) do
      {:ok, %{"data" => data}} -> {:ok, Enum.map(data, &Gif.from_api/1)}
      {:error, _} = error -> error
    end
  end

  def get(id) do
    case get_request("#{@base_url}/#{URI.encode(id)}", %{}) do
      {:ok, %{"data" => data}} -> {:ok, Gif.from_api(data)}
      {:error, _} = error -> error
    end
  end

  defp get_request(url, params) do
    api_key = Application.get_env(:giphy_api, :api_key)

    if is_nil(api_key) do
      {:error, :missing_api_key}
    else
      params = Map.put(params, :api_key, api_key)

      case Req.get(url, params: params) do
        {:ok, %{status: 200, body: body}} when is_map(body) ->
          {:ok, body}

        {:ok, %{status: 200, body: body}} when is_binary(body) ->
          case Jason.decode(body) do
            {:ok, decoded} -> {:ok, decoded}
            {:error, _} -> {:error, :invalid_json}
          end

        {:ok, %{status: status}} ->
          {:error, "HTTP #{status}"}

        {:error, reason} ->
          {:error, reason}
      end
    end
  end
end
