# very nice and detailed requester :thumbsup:

defmodule WeebPotion.Requester do
  use HTTPoison.Base
  def process_request_url(url), do: "https://api.weeb.sh/images" <> url
end