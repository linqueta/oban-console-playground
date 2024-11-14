defmodule ObanConsolePlayground.Workers.ProcessPayment do
  use Oban.Worker, queue: :order

  alias ObanConsolePlayground.Workers.ShipOrder

  @impl true
  def perform(%Oban.Job{args: %{"customer_id" => customer_id}}) do
    Utils.random_sleep()

    die = Enum.random(1..100)

    request_payment_gateway(die, customer_id)
  end

  defp request_payment_gateway(value, _) when value < 20,
    do: raise("Payment gateway request failed")

  defp request_payment_gateway(value, _) when value < 50,
    do: {:error, :payment_declined_try_again}

  defp request_payment_gateway(_, customer_id) do
    ShipOrder.new(%{customer_id: customer_id}) |> Oban.insert!()

    :ok
  end
end
