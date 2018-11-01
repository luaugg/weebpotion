defmodule WeebPotion.Struct.Image do
  @derive [Poison.Encoder]
  defstruct [
    :id,
    :type,
    :baseType,
    :nsfw,
    :fileType,
    :mimeType,
    :tags,
    :url,
    :hidden,
    :source,
    :account
  ]
end