defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  setup do
    BookingAgent.start_link(%{})

    build(:booking, id: "26f107a3-9a51-49eb-834c-0b15d3c4253f")
    |> BookingAgent.save()

    :ok
  end

  describe "save/1" do
    test "return :ok , when booking is saved" do
      booking = build(:booking)
      assert :ok = BookingAgent.save(booking)
    end

    test "return an error, when parameter is inavlid" do
      assert {:error, "Invalid Booking struct"} = BookingAgent.save(%{})
    end
  end

  describe "get/1" do
    test "return a booking" do
      assert {:ok, %Booking{id: id}} = BookingAgent.get("26f107a3-9a51-49eb-834c-0b15d3c4253f")
      assert id == "26f107a3-9a51-49eb-834c-0b15d3c4253f"
    end

    test "return an error, when booking not exists" do
      assert {:error, "Flight booking not found."} =
               BookingAgent.get("26f107a4-9a51-49eb-834c-0b15d3c4253f")
    end
  end
end
