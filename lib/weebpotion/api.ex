#   Copyright 2018 Samuel Pritchard
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

defmodule WeebPotion.Api do
  @moduledoc """
  Contains all the functionality of WeebPotion, such as requesting random images (via `random_image!/2` and `random_image/2`) etc.
  All function names ending with an exclamation mark indicate functions that fail-fast, as is Erlang tradition.
  """
  alias WeebPotion.Struct.Image

  import WeebPotion.Requester
  import Poison

  @doc """
  Requests a random image with a given type from weeb.sh, but fails fast unlike the "non-banged" `random_image/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance.
  - `opts`: A key-word list of arguments which can be passed to return different results.

  ## Examples
  ```
  iex>WeebPotion.Api.random_image(client, type: "cry")
  %WeebPotion.Struct.Image{
    account: "HyxjFGfPb",
    baseType: "cry",
    fileType: "gif",
    hidden: false,
    id: "r1WMmLQvW",
    mimeType: "image/gif",
    nsfw: false,
    source: nil,
    tags: [],
    type: "cry",
    url: "https://cdn.weeb.sh/images/r1WMmLQvW.gif"
  }
  ```

  ## Supported Options
  - `type`: A mandatory option which tells weeb.sh what type of image to send.
  - `nsfw`: If NSFW images should be sent. Can be equal to `true`, `false` or `:only`. Defaults to `false`.
  - `hidden`: If hidden images you uploaded should be sent. Can be equal to `true` or `false`. Defaults to `false`.
  - `filetype`: What filetype images should be. Can be equal to `:gif`, `:jpg`, `:jpeg`, `:png` or `:both`. Defaults to `:both`.
  """
  @spec random_image!(WeebPotion.Struct.Client.t(), list()) :: Image.t()
  def random_image!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype] || :both
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    get!(link, client.headers, recv_timeout: 500).body
    |> decode!(as: %Image{})
  end

  @doc """
  Requests a random image with a given type from weeb.sh, but doesn't fail fast unlike the "banged" `random_image!/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance.
  - `opts`: A key-word list of arguments which can be passed to return different results.

  ## Examples
  ```
  iex>WeebPotion.Api.random_image(client, type: "cry")
  {:ok, %WeebPotion.Struct.Image{
    account: "HyxjFGfPb",
    baseType: "cry",
    fileType: "gif",
    hidden: false,
    id: "r1WMmLQvW",
    mimeType: "image/gif",
    nsfw: false,
    source: nil,
    tags: [],
    type: "cry",
    url: "https://cdn.weeb.sh/images/r1WMmLQvW.gif"
  }}
  ```

  ## Supported Options
  - `type`: A mandatory option which tells weeb.sh what type of image to send.
  - `nsfw`: If NSFW images should be sent. Can be equal to `true`, `false` or `:only`. Defaults to `false`.
  - `hidden`: If hidden images you uploaded should be sent. Can be equal to `true` or `false`. Defaults to `false`.
  - `filetype`: What filetype images should be. Can be equal to `:gif`, `:jpg`, `:jpeg`, `:png` or `:both`. Defaults to `:both`.
  """
  @spec random_image(WeebPotion.Struct.Client.t(), list()) :: {:ok, Image.t()} | {:error, any()}
  def random_image(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype] || :both
    if filetype !== :both, do: link <> "&filetype=#{filetype}"
    try do
      {:ok, response} = get(link, client.headers, recv_timeout: 500)
      {:ok, image} = decode(response.body(), as: %Image{})
    catch
      e -> {:error, e}
    end
  end

  @doc """
  Requests an image object associated with a specific ID and fails-fast unlike the "non-banged" `image_info/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate the request.
  - `image_id`: The ID of the image you want information on.

  ## Examples
  ```
  iex>WeebPotion.Api.image_info!(client, "r1WMmLQvW")
  %WeebPotion.Struct.Image{
    account: "HyxjFGfPb",
    baseType: "cry",
    fileType: "gif",
    hidden: false,
    id: "r1WMmLQvW",
    mimeType: "image/gif",
    nsfw: false,
    source: nil,
    tags: [],
    type: "cry",
    url: "https://cdn.weeb.sh/images/r1WMmLQvW.gif"
  }
  ```
  """
  @spec image_info!(WeebPotion.Struct.Client.t(), String.t()) :: Image.t()
  def image_info!(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    get!(link, client.headers, recv_timeout: 500).body
    |> decode!(as: %Image{})
  end

  @doc """
  Requests an image object associated with a specific ID but doesn't fail fast unlike the "banged" `image_info!/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate the request.
  - `image_id`: The ID of the image you want information on.

  ## Examples
  ```
  iex>WeebPotion.Api.image_info(client, "r1WMmLQvW")
  {:ok, %WeebPotion.Struct.Image{
    account: "HyxjFGfPb",
    baseType: "cry",
    fileType: "gif",
    hidden: false,
    id: "r1WMmLQvW",
    mimeType: "image/gif",
    nsfw: false,
    source: nil,
    tags: [],
    type: "cry",
    url: "https://cdn.weeb.sh/images/r1WMmLQvW.gif"
  }}
  ```
  """
  @spec image_info(WeebPotion.Struct.Client.t(), String.t()) :: {:ok, Image.t()} | {:error, any()}
  def image_info(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    try do
        {:ok, response} = get(link, client.headers, recv_timeout: 500)
        {:ok, image} = decode(response.body(), as: %Image{})
    catch
      e -> {:error, e}
    end
  end

  @doc """
  Requests a list of image types which change depending on the options passed. Doesn't fail fast unlike the "banged" `image_types!/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate the request.
  - `opts`: A key-word list of options that modify the response received.

  ## Examples
  ```
  iex>WeebPotion.Api.image_types(client, preview: true)
  {:ok, [{"awoo", %{
    "baseType" => "awoo",
    "fileType" => "gif",
    "id" => "BJZfMrXwb",
    "type" => "awoo",
    "url" => "https://cdn.weeb.sh/images/BJZfMrXwb.gif"
   }}, ...]}
  ```
  ```
  iex>WeebPotion.Api.image_types(client)
  {:ok, ["awoo", "bang", "blush", ...]}
  ```

  ## Supported Options
  - `:nsfw`: Whether or not NSFW image types should be returned. Defaults to `false`.
  - `:hidden`: Whether or not hidden images you uploaded should be returned. Defaults to `false`.
  - `:preview`: Whether or not preview images should be returned along with their associated types. Defaults to `false`.
  """
  @spec image_types(WeebPotion.Struct.Client.t(), list()) :: {:ok, list()} | {:ok, [{String.t(), map()}]} | {:error, any()}
  def image_types(client, opts \\ []) when (client !== nil and is_list(opts)) do
    preview = opts[:preview] || false
    link = "/types?&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}&preview=#{preview}"
    try do
      {:ok, response} = get(link, client.headers, recv_timeout: 500)
      {:ok, body} = decode(response.body())
      if preview do
        {:ok, types} = Map.fetch(body, "types")
        {:ok, preview} = Map.fetch(body, "preview")
        types
        |> Enum.with_index
        |> Enum.map(&({elem(&1, 0), Enum.at(preview, elem(&1, 1))}))
      else
        {:ok, types} = Map.fetch(body, "types")
      end
    catch
      e -> {:error, e}
    end
  end

  @doc """
  Requests a list of image types which change depending on the options passed. Fails fast unlike the "non-banged" `image_types/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate the request.
  - `opts`: A key-word list of options that modify the response received.

  ## Examples
  ```
  iex>WeebPotion.Api.image_types(client, preview: true)
  [{"awoo", %{
    "baseType" => "awoo",
    "fileType" => "gif",
    "id" => "BJZfMrXwb",
    "type" => "awoo",
    "url" => "https://cdn.weeb.sh/images/BJZfMrXwb.gif"
   }}, ...]
  ```
  ```
  iex>WeebPotion.Api.image_types(client)
  ["awoo", "bang", "blush", ...]
  ```

  ## Supported Options
  - `:nsfw`: Whether or not NSFW image types should be returned. Defaults to `false`.
  - `:hidden`: Whether or not hidden images you uploaded should be returned. Defaults to `false`.
  - `:preview`: Whether or not preview images should be returned along with their associated types. Defaults to `false`.
  """
  @spec image_types!(WeebPotion.Struct.Client.t(), list()) :: list() | [{String.t(), map()}]
  def image_types!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    preview = opts[:preview] || false
    link = "/types?&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}&preview=#{preview}"
    {:ok, response} = get(link, client.headers, recv_timeout: 500)
    body = decode!(response.body())
    if preview do
      types = Map.fetch!(body, "types")
      preview = Map.fetch!(body, "preview")
      types
      |> Enum.with_index
      |> Enum.map(&({elem(&1, 0), Enum.at(preview, elem(&1, 1))}))
    else
      Map.fetch!(body, "types")
    end
  end

  @doc """
  Requests a list of image tags. Doesn't fail fast unlike the "banged" `image_tags!/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate requests.
  - `opts`: A key-word list of options that modify the response received.

  ## Examples
  ```
  iex>WeebPotion.Api.image_tags(client)
  {:ok, ["nuzzle", "cuddle", "momiji inubashiri", "wan", "astolfo", "facedesk",
  "everyone", "b1nzy", "trap_normal", "trap_memes", "meta-pixiv-8189060"]}
  ```

  ## Supported Options
  - `:hidden` - Whether or not to show hidden image tags you uploaded. Defaults to `false`.
  - `:nsfw` - Whether or not to show NSFW image tags. Defaults to `false`.
  """
  @spec image_tags(WeebPotion.Struct.Client.t(), list()) :: {:ok, list()} | {:error, any()}
  def image_tags(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/tags?hidden=#{opts[:hidden] || false}&nsfw=#{opts[:nsfw] || false}"
    try do
      {:ok, response} = get(link, client.headers, recv_timeout: 500)
      {:ok, body} = decode(response.body())
      {:ok, tags} = Map.fetch(body, "tags")
    catch
      e -> {:error, e}
    end
  end


  @doc """
  Requests a list of image tags. Fails fast unlike the "non-banged" `image_tags/2` variant.

  ## Parameters
  - `client`: A `WeebPotion.Struct.Client` instance, used to authenticate requests.
  - `opts`: A key-word list of options that modify the response received.

  ## Examples
  ```
  iex>WeebPotion.Api.image_tags(client)
  ["nuzzle", "cuddle", "momiji inubashiri", "wan", "astolfo", "facedesk",
  "everyone", "b1nzy", "trap_normal", "trap_memes", "meta-pixiv-8189060"]
  ```

  ## Supported Options
  - `:hidden` - Whether or not to show hidden image tags you uploaded. Defaults to `false`.
  - `:nsfw` - Whether or not to show NSFW image tags. Defaults to `false`.
  """
  @spec image_tags!(WeebPotion.Struct.Client.t(), list()) :: list()
  def image_tags!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/tags?hidden=#{opts[:hidden] || false}&nsfw=#{opts[:nsfw] || false}"
    get!(link, client.headers, recv_timeout: 500).body()
    |> decode!()
    |> Map.fetch!("tags")
  end
end