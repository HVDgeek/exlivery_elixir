defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "Save the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "1234567800"

      {:ok, cpf: cpf}
    end

    test "When the user is found, returns user", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response = {:ok, build(:user, cpf: cpf)}

      assert response == expected_response
    end

    test "When the user is not found, returns an error", %{cpf: cpf} do
      response = UserAgent.get(cpf)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
