defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "1234567800"

      user = build(:user, cpf: cpf)

      Exlivery.start_agents()
      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza de calabreza",
        unity_price: "30.50",
        quantity: 1
      }

      item2 = %{
        category: :sobremesa,
        description: "Açaí",
        unity_price: "20.0",
        quantity: 2
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "When all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "When there is no user with given cpf, returns an error", %{item1: item1, item2: item2} do
      params = %{user_cpf: "any_cpf", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "When there are no items, returns an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
