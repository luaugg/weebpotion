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

defmodule WeebPotion.Requester do
  @moduledoc """
  Requester Module used entirely for shortening links. May be expanded on in the future.

  Provides the `process_request_url/1` function to do just that.
  """
  use HTTPoison.Base

  @doc """
  Prepends `https://api.weeb.sh/images` to all URLs that requests are made to via this requester.

  ## Parameters

  - `url`: String that represents any weeb.sh endpoint.

  ## Examples
  ```
  iex> WeebPotion.Requester.process_request_url("/random")
  "https://api.weeb.sh/images/random"
  ```
  """
  @spec process_request_url(String.t()) :: String.t()
  def process_request_url(url), do: "https://api.weeb.sh/images" <> url
end