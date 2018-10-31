defmodule WeebPotion.Struct.Client do
  defstruct token_type: :Wolke, token: nil, environment: :dev

  @type t :: %__MODULE__{}

  def start(opts), do: WeebPotion.Requester.start

  @spec new(String.t, atom, atom) :: t
  def new(token, token_type \\ :Wolke, environment \\ :dev) when (token_type === :Wolke or token_type === :Bearer) do
    %__MODULE__{token: token, token_type: token_type, environment: environment}
  end

  def random_image!(client, opts \\ []) when (client !== nil and opts !== nil and is_list(opts)) do
    link = "random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    headers = ["Authorization": "#{client.token_type} #{client.token}"]
    WeebPotion.Requester.get!(link, headers, recv_timeout: 500).body
    |> Poison.decode!(as: %WeebPotion.Struct.Image{})
  end

  def random_image(client, opts \\ []) when (client !== nil and opts !== nil and is_list(opts)) do
    link = "random?type=#{opts[:type]}&nsfw=#{opts[:nsfw] || false}&hidden=#{opts[:hidden] || false}"
    filetype = opts[:filetype]
    if filetype !== :both, do: link <> "&filetype=#{filetype}"

    headers = ["Authorization": "#{client.token_type} #{client.token}"]
    {:ok, response} = WeebPotion.Requester.get(link, headers, recv_timeout: 500)
    Poison.decode(response.body(), as: %WeebPotion.Struct.Image{})
  end
end