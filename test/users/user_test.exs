defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User

  describe "]build/5" do
    test "When all params are valid, returns user" do
      response =
        User.build(
          "Ruas Independencia",
          "Hiduino",
          "name@mail.com",
          "123.456.789-10",
          26
        )

      expected_response =
        {:ok,
         %User{
           address: "Ruas Independencia",
           age: 26,
           cpf: "123.456.789-10",
           email: "name@mail.com",
           name: "Hiduino"
         }}

      assert response == expected_response
    end

    test "When there are invalid params, return error" do
      response =
        User.build(
          "Ruas Independencia",
          "Hiduino",
          "name@mail.com",
          "123.456.789-10",
          15
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
