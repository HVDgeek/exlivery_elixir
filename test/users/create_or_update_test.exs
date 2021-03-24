defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/5" do
    setup do
      UserAgent.start_link(%{})

      params = %{
        address: "Rua Independencia",
        name: "Hiduino",
        email: "mail@mail.com",
        cpf: "1234567800",
        age: 20
      }

      {:ok, params: params}
    end

    test "When all params are valid , saves the user", %{params: params} do
      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "When there are invalid params , returns an error", %{params: params} do
      user = %{params | age: 5}

      response = CreateOrUpdate.call(user)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
