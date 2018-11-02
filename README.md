# weebpotion

An [Elixir](https://elixir-lang.org/) wrapper for the `toph` portion of [weeb.sh](https://weeb.sh). Toph refers to the standard image
features like fetching crying images. weebpotion will eventually support the rest of the `weeb.sh` API, but for now only `toph` is supported.

# Adding weebpotion

weebpotion is available in [Hex](https://hex.pm/) so you can add it as you would any other dependency:
```elixir
def deps do
  [
    {:weebpotion, "~> 0.2.1"}
  ]
end
```

Documentation [can be found here.](https://hexdocs.pm/weebpotion/api-reference.html)

# Basic Usage

All functionality in weebpotion is located in the `WeebPotion.Api` module, and all of it depends on a `WeebPotion.Struct.Client`
which you can obtain with the following code:

```elixir
WeebPotion.Struct.Client.start [] # Mandatory -- use this to start the HTTPoison Requester.
client = WeebPotion.Struct.Client.new(token: "your weeb.sh token", application_name: "test", version: "1.0.0")
# Check out the documentation to see all the options accepted by the `new/1` function.
```

Then you can do things such as fetching images with the code:
```elixir
WeebPotion.Api.random_image!(client, type: "cry").url
|> IO.inspect

# image URL
# again, check out the documentation to see all the accepted options.
```

> Note: In accordance with Erlang tradition, "banged" method alternatives (ones whose names end with exclamation marks)
exist which fail fast instead of returning `:ok` and `:error` tuples.

# Maps vs Structs

Due to my own inexperience/lack of knowledge using Poison in a complicated manner and also the fact that I want to
save performance, `WeebPotion.Struct.Image` structs are only returned if the response itself is an image object.

If it needs to be converted or modified in any way, weebpotion will just return the raw map instead of a converted image struct.


