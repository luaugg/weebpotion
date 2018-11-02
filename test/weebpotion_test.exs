defmodule WeebPotionTest do
  use ExUnit.Case

  setup_all do
    WeebPotion.Struct.Client.start []
    client = WeebPotion.Struct.Client.new(token: System.get_env("client_token"), application_name: "test", version: "1.0.0", environment: "test")
    |> IO.inspect
    {:ok, client: client}
  end

  test "get all image types banged", state do
    IO.inspect WeebPotion.Api.image_types!(state[:client])
  end

  test "get all image types", state do
    IO.inspect WeebPotion.Api.image_types(state[:client], preview: true)
  end

  test "get all image tags banged", state do
    IO.inspect WeebPotion.Api.image_tags!(state[:client], preview: true)
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
