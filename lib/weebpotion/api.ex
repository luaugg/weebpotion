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

    {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
    decode(response.body(), as: %Image{})
  end

  def image_info!(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    get!(link, client.auth_header, recv_timeout: 500).body
    |> decode!(as: %Image{})
  end

  def image_info(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    {:ok, response} = get(link, client.auth_header, recv_timeout: 500)
    decode(response.body(), as: %Image{})
  end
end