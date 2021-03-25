defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "generate report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "123.456.789-10,pizza,2,55.8japonesa,3,25.50,188.10\n" <>
          "123.456.789-10,pizza,2,55.8japonesa,3,25.50,188.10\n"

      assert response == expected_response
    end
  end
end
