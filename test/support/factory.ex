defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Ruas Independencia",
      name: "Hiduino",
      email: "name@mail.com",
      cpf: "123.456.789-10",
      age: 26
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de peperoni",
      quantity: 2,
      unity_price: Decimal.new("55.8")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Ruas Independencia",
      items: [
        build(:item),
        build(:item,
          category: :japonesa,
          description: "Temaki de Atum",
          quantity: 3,
          unity_price: Decimal.new("25.50")
        )
      ],
      total_price: Decimal.new("188.10"),
      user_cpf: "123.456.789-10"
    }
  end
end
