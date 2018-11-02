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