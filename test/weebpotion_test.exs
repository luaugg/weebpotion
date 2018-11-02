defmodule WeebPotionTest do
  use ExUnit.Case
  doctest WeebPotion.Api

  setup_all do
    WeebPotion.Struct.Client.start []
    {:ok, client: WeebPotion.Struct.Client.new(System.get_env("client_token"))}
  end

  test "get all image types banged", state do
    IO.inspect WeebPotion.Api.image_types!(state[:client])
  end

  test "get all image types", state do
    IO.inspect WeebPotion.Api.image_types(state[:client])
  end

  test "get all image tags banged", state do
    IO.inspect WeebPotion.Api.image_tags!(state[:client])
  end

  test "get all image tags", state do
    IO.inspect WeebPotion.Api.image_tags(state[:client])
  end

  test "get random image banged", state do
    IO.inspect WeebPotion.Api.random_image!(state[:client], type: "cry")
  end

  test "get random image", state do
    IO.inspect WeebPotion.Api.random_image(state[:client], type: "cry")
  end

  test "image info banged", state do
    client = state[:client]
    id = WeebPotion.Api.random_image!(client, type: "cry").id()

    IO.inspect WeebPotion.Api.image_info!(client, id) # can just view the image object above but these are tests
  end

  test "image info", state do
    client = state[:client]
    id = WeebPotion.Api.random_image!(client, type: "cry").id()

    IO.inspect WeebPotion.Api.image_info(client, id)
  end
end
