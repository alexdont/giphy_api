defmodule GiphyApi.Gif do
  @moduledoc """
  Struct representing a Giphy GIF with pre-selected URLs for common use cases.
  """

  @type t :: %__MODULE__{
          id: String.t(),
          title: String.t(),
          url: String.t(),
          preview_url: String.t(),
          preview_width: integer(),
          preview_height: integer(),
          original_url: String.t(),
          original_width: integer(),
          original_height: integer(),
          downsized_url: String.t(),
          username: String.t() | nil
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :title,
    :url,
    :preview_url,
    :preview_width,
    :preview_height,
    :original_url,
    :original_width,
    :original_height,
    :downsized_url,
    :username
  ]

  @doc """
  Parse a Giphy API response item into a Gif struct.
  """
  def from_api(%{"id" => id} = data) do
    images = data["images"] || %{}
    fixed_width = images["fixed_width"] || %{}
    original = images["original"] || %{}
    downsized = images["downsized_medium"] || images["downsized"] || original

    %__MODULE__{
      id: id,
      title: data["title"] || "",
      url: data["url"] || "",
      preview_url: fixed_width["url"] || "",
      preview_width: parse_int(fixed_width["width"]),
      preview_height: parse_int(fixed_width["height"]),
      original_url: original["url"] || "",
      original_width: parse_int(original["width"]),
      original_height: parse_int(original["height"]),
      downsized_url: downsized["url"] || "",
      username: data["username"]
    }
  end

  defp parse_int(nil), do: 0
  defp parse_int(n) when is_integer(n), do: n

  defp parse_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {n, _} -> n
      :error -> 0
    end
  end
end
