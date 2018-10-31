defmodule WeebPotion.Requester.Supervisor do
  use Supervisor
  def start_link(opts), do: Supervisor.start_link(__MODULE__, :ok, opts)
  def init(:ok), do: Supervisor.init([WeebPotion.Requester], strategy: :one_for_one)
end