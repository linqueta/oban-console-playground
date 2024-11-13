defmodule ObanConsolePlayground.AccountsTest do
  use ObanConsolePlayground.DataCase

  alias ObanConsolePlayground.Accounts

  describe "customers" do
    alias ObanConsolePlayground.Accounts.Customer

    import ObanConsolePlayground.AccountsFixtures

    @invalid_attrs %{name: nil, email: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{name: "some name", email: "some email"}

      assert {:ok, %Customer{} = customer} = Accounts.create_customer(valid_attrs)
      assert customer.name == "some name"
      assert customer.email == "some email"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email"}

      assert {:ok, %Customer{} = customer} = Accounts.update_customer(customer, update_attrs)
      assert customer.name == "some updated name"
      assert customer.email == "some updated email"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end
end
