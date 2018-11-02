defmodule WeebPotionTest do
  use ExUnit.Case
  doctest WeebPotion.Api

  setup_all do
    WeebPotion.Struct.Client.start []
    {:ok, client: WeebPotion.Struct.Client.new(System.get_env("client_token"))}
  end
end
