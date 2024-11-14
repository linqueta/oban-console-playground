defmodule ObanConsolePlayground.Workers.PlaceOrder do
  use Oban.Worker, queue: :order

  alias ObanConsolePlayground.Workers.ProcessPayment

  @impl true
  def perform(%Oban.Job{args: %{"customer_id" => customer_id}}) do
    Utils.random_sleep()

    if Utils.chance?(30), do: customer_cancels_order(), else: process_payment(customer_id)
  end

  defp customer_cancels_order, do: {:cancel, :order_cancelled}

  defp process_payment(customer_id) do
    ProcessPayment.new(%{customer_id: customer_id}) |> Oban.insert!()

    :ok
  end
end
