defmodule ObanConsolePlayground.Workers.RegisterCustomer do
  use Oban.Worker, queue: :registration

  @impl true
  def perform(%Oban.Job{}) do
    name = Faker.Person.name()
    email = "#{name |> String.downcase() |> String.replace(" ", ".")}@#{Faker.Internet.domain_name()}"

    ObanConsolePlayground.Accounts.create_customer(%{name: name, email: email})

    :ok
  end
end
