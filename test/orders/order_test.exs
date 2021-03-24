defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/4" do
    test "When all params are valid, returns an Order" do
      user = build(:user)

      items = [
        build(:item),
        build(
          :item,
          description: "Temaki de Atum",
          category: :japonesa,
          unity_price: Decimal.new("25.50"),
          quantity: 3
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "When there is no items in the order, return error" do
      user = build(:user)
      items = []
      response = Order.build(user, items)

      expected_tesponse = {:error, "Invalid parameters!"}

      assert response == expected_tesponse
    end
  end
end
