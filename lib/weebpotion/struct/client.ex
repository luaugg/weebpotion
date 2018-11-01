defmodule WeebPotion.Struct.Client do
  defstruct token_type: :Wolke, token: nil, environment: :dev, auth_header: nil

  @typedoc """

  """
  @type t :: %__MODULE__{}

  def start(opts), do: WeebPotion.Requester.start

  @spec new(String.t, atom, atom) :: t
  def new(token, token_type \\ :Wolke, environment \\ :dev) when (token_type === :Wolke or token_type === :Bearer) do
    %__MODULE__{token: token, token_type: token_type, environment: environment, auth_header: ["Authorization": "#{token_type} #{token}"]}
  end

  def random_image!(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    WeebPotion.Requester.get!(link, client.auth_header, recv_timeout: 500).body
    |> Poison.decode!(as: %WeebPotion.Struct.Image{})
  end

  def random_image(client, opts \\ []) when (client !== nil and is_list(opts)) do
    link = "random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    {:ok, response} = WeebPotion.Requester.get(link, client.auth_header, recv_timeout: 500)
    Poison.decode(response.body(), as: %WeebPotion.Struct.Image{})
  end

  def image_info!(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    WeebPotion.Requester.get!(link, client.auth_header, recv_timeout: 500).body
    |> Poison.decode!(as: %WeebPotion.Struct.Image{})
  end

  def image_info(client, image_id) when (client !== nil and is_binary(image_id)) do
    link = "/info/#{image_id}"
    {:ok, response} = WeebPotion.Requester.get(link, client.auth_header, recv_timeout: 500)
    Poison.decode(response.body(), as: %WeebPotion.Struct.Image{})
  end
end