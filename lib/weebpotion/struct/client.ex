defmodule WeebPotion.Struct.Client do
  defstruct token_type: :Wolke, token: nil, environment: :dev

  @type t :: %__MODULE__{}

  def start(opts), do: HTTPoison.start

  @spec new(String.t, atom, atom) :: t
  def new(token, token_type \\ :Wolke, environment \\ :dev) when (token_type === :Wolke or token_type === :Bearer) do
    %__MODULE__{token: token, token_type: token_type, environment: environment}
  end

  def random_image!(client, opts \\ []) when (client !== nil and opts !== nil and is_list(opts)) do
    type = opts[:type]
    if type === nil or !is_binary(type) or !is_atom(type), do: raise "type is nil or not a string/atom"

    nsfw = opts[:nsfw] || false
    if type !== nil and !is_boolean(nsfw), do: raise "nsfw is not a boolean"

    hidden = opts[:nsfw] || false
    if hidden !== nil and !is_boolean(hidden), do: raise "hidden is not a boolean"

    filetype = opts[:filetype] || :both
    if filetype !== nil and !is_atom(filetype), do: raise "filetype is not an atom"

    link = "https://api.weeb.sh/images/random?type=#{opts[:type]}&nsfw=#{opts[:nsfw]}&hidden=#{hidden}"
    if filetype != :both, do: link <> "&filetype=#{filetype}"

    headers = ["Authorization": "#{client.token_type} #{client.token}"]
    HTTPoison.get!(link, headers, recv_timeout: 500).body
    |> Poison.decode!()
  end

end