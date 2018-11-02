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

  @typedoc """
  Represents a single image returned from weeb.sh. As of v0.2.0, this type is only returned for
  responses which are just images, so lists containing images will just be maps inside lists.
  The keys are as follows:

  * `:id` - Binary string equal to the ID of the image.
  * `:type` - Binary string equal to the type of the image.
  * `:baseType` - Binary string equal to the base-type of the image.
  * `:nsfw` - Boolean equal to whether or not the image is NSFW.
  * `:fileType` - Binary string equal to the filetype of the image.
  * `:mimeType` - Binary string equal to the MIME type of the image.
  * `:tags` - A list of tags that are applied to the image.
  * `:url` - Binary string equal to the URL that points to the image.
  * `:hidden` - Boolean equal to whether or not the image is only visible to its uploader.
  * `:source` - Possibly-nil binary string equal to the source of the image (almost always `nil`).
  * `:account` - Binary string equal to the ID of the account that uploaded the image.
  """
  @type t :: %__MODULE__{}
end