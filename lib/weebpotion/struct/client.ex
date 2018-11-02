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
  defstruct token_type: :Wolke, token: nil, application_name: nil, version: nil, environment: "dev", headers: nil

  @typedoc """
  This type represents the client needed to authenticate requests and hold small pieces of information. The keys are as follows:

  * `:token_type` - An atom that can be either `:Wolke` or `:Bearer`. All modern weeb.sh tokens are of the `:Wolke` type.
  * `:token` - A binary string equal to your weeb.sh token used to authenticate requests.
  * `:application_name` - A binary string equal to the name of the application.
  * `:version` - A binary string equal to the version of the application.
  * `:environment` - A binary string representing the environment of the application, such as `dev` or `alpha`.
  * `:headers` - A key-word list containing the HTTP Headers, used to avoid re-creating constant information.
  """
  @type t :: %__MODULE__{}

  @doc false
  def start(opts), do: WeebPotion.Requester.start

  @doc """
  Constructs a new client struct using the options passed in via the `opts` key-word list.

  ## Parameters
  - `opts`: A key-word list containing options to construct a client with.

  ## Examples
  ```
  iex>WeebPotion.Struct.Client.new(token: "redacted", name: "test", version: "0.1.0")
  %WeebPotion.Struct.Client{
    application_name: "test",
    auth_header: [
      Authorization: "Wolke redacted",
      "User-Agent": "test/0.1.0/dev"
    ],
    environment: "dev",
    token: "redacted",
    token_type: :Wolke,
    version: "0.1.0"
  }
  ```
  """
  @spec new(list()) :: t
  def new(opts) when (is_list(opts)) do
    token_type = opts[:token_type] || :Wolke
    token = opts[:token]
    if !is_binary(token), do: raise "token is nil or not a binary string"

    environment = opts[:environment] || "dev"
    version = opts[:version]
    if !is_binary(version), do: raise "version is nil or not a binary string"

    name = opts[:application_name]
    if !is_binary(name), do: raise "application_name is nil or not a binary string"

    %__MODULE__{token_type: token_type, token: token, application_name: name, version: version, environment: environment,
      headers: ["Authorization": "#{token_type} #{token}", "User-Agent": "#{name}/#{version}/#{environment}"]}
  end
end