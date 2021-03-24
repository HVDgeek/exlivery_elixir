defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "When all params are valid, returns an item" do
      response = Item.build("Pizza de peperoni", :pizza, "55.8", 2)

      expected_tesponse = {:ok, build(:item)}

      assert response == expected_tesponse
    end

    test "When there are invalid category, return error" do
      response = Item.build("Pizza de peperoni", :banana_category, "55.8", 2)

      expected_tesponse = {:error, "Invalid parameters"}

      assert response == expected_tesponse
    end

    test "When there is a invalid price, return error" do
      response = Item.build("Pizza de peperoni", :pizza, "banana_price", 2)

      expected_tesponse = {:error, "Invalid price!"}

      assert response == expected_tesponse
    end

    test "When there is a invalid quantity, return error" do
      response = Item.build("Pizza de peperoni", :pizza, "44.0", 0)

      expected_tesponse = {:error, "Invalid parameters"}

      assert response == expected_tesponse
    end
  end
end
