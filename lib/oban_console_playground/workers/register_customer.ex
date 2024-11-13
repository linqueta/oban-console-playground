defmodule ObanConsolePlayground.Workers.RegisterCustomer do
  use Oban.Worker, queue: :registration

  @impl true
  def perform(%Oban.Job{}) do
    ObanConsolePlayground.Accounts.create_customer(%{
      name: Faker.Person.name(),
      email: Faker.Internet.email()
    })

    :ok
  end
end
