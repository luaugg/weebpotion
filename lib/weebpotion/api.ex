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
  alias WeebPotion.Struct.Image

  import WeebPotion.Requester
  import Poison

  def random_image!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    get!(link, client.auth_header, recv_timeout: 500).body
    |> decode!(as: %Image{})
  end

  def random_image(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"
    try do
      {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
      {:ok, image} = decode(response.body(), as: %Image{})
    catch
      e -> {:error, e}
    end
  end

  def image_info!(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    get!(link, client.auth_header, recv_timeout: 500).body
    |> decode!(as: %Image{})
  end

  def image_info(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    try do
        {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
        {:ok, image} = decode(response.body(), as: %Image{})
    catch
      e -> {:error, e}
    end
  end

  def image_types(client, opts \\ []) when (client !== nil and is_list(opts)) do
    preview = opts[:preview] || false
    link = "/types?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}&preview=#{preview}"
    try do
      {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
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

  def image_types!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    preview = opts[:preview] || false
    link = "/types?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}&preview=#{preview}"
    {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
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

  def image_tags(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/tags?hidden=#{opts[:hidden] || false}&nsfw=#{opts[:nsfw] || false}"
    try do
      {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
      {:ok, body} = decode(response.body())
      {:ok, tags} = Map.fetch(body, "tags")
    catch
      e -> {:error, e}
    end
  end

  def image_tags!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "/tags?hidden=#{opts[:hidden] || false}&nsfw=#{opts[:nsfw] || false}"
    get!(link, client.auth_header, recv_timeout: 500).body()
    |> decode!()
    |> Map.fetch!("tags")
  end
end