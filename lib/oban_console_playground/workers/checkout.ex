defmodule ObanConsolePlayground.Workers.Checkout do
  use Oban.Worker, queue: :default

  alias ObanConsolePlayground.Accounts.Customer
  alias ObanConsolePlayground.Repo
  alias ObanConsolePlayground.Workers.PlaceOrder

  import Ecto.Query

  @impl true
  def perform(%Oban.Job{}) do
    limit = Enum.random(3..10)

    Repo.all(from c in Customer, limit: ^limit)
    |> Enum.map(fn %Customer{id: id} -> PlaceOrder.new(%{customer_id: id}) end)
    |> Enum.each(fn job ->
      Utils.random_sleep()

      Oban.insert!(job)
    end)

    :ok
  end
end
