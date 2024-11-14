defmodule ObanConsolePlayground.Workers.ShipOrder do
  use Oban.Worker, queue: :order

  alias ObanConsolePlayground.Repo

  @impl true
  def perform(
        %Oban.Job{args: %{"customer_id" => _, "day" => day, "expected" => expected}} =
          job
      ) do
    Utils.random_sleep()

    current_day = day + 1

    job
    |> Ecto.Changeset.change(args: Map.merge(job.args, %{day: current_day}))
    |> Repo.update!()

    die = Enum.random(1..100)

    track_order(die, current_day, expected)
  end

  def perform(%Oban.Job{args: %{"customer_id" => _}} = job) do
    Utils.random_sleep()

    expected = Enum.random(3..10)

    job
    |> Ecto.Changeset.change(args: Map.merge(job.args, %{day: 1, expected: expected}))
    |> Repo.update!()

    {:snooze, 5}
  end

  defp track_order(value, _, _) when value < 20, do: {:cancel, :truck_crashed}
  defp track_order(_, current_day, expected) when current_day < expected, do: {:snooze, 5}
  defp track_order(_, _, _), do: {:ok, :order_delivered}
end
