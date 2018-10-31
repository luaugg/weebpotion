defmodule WeebPotion.Struct.Image do
  @derive [Poison.Encoder]
  defstruct [
    :account,
    :baseType,
    :fileType,
    :hidden,
    :id,
    :mimeType,
    :nsfw,
    :status,
    :tags,
    :type,
    :url
  ]
end