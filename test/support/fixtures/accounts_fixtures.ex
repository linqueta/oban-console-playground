defmodule ObanConsolePlayground.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ObanConsolePlayground.Accounts` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> ObanConsolePlayground.Accounts.create_customer()

    customer
  end
end
