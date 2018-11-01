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
end