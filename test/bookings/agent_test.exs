defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  setup do
    BookingAgent.start_link(%{})

    build(:booking, id: "26f107a3-9a51-49eb-834c-0b15d3c4253f")
    |> BookingAgent.save()

    booking_a =
      build(:booking, %{
        complete_date: ~N[2021-06-10 08:00:00],
        id: "26f107a3-9a51-49eb-834c-0b15d3c4253a"
      })

    booking_b =
      build(:booking, %{
        complete_date: ~N[2021-06-11 08:00:00],
        id: "26f107a3-9a51-49eb-834c-0b15d3c4253b"
      })

    booking_c =
      build(:booking, %{
        complete_date: ~N[2021-06-21 08:00:00],
        id: "26f107a3-9a51-49eb-834c-0b15d3c4253c"
      })

    [booking_a, booking_b, booking_c]
    |> Enum.map(&BookingAgent.save/1)

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

  describe "get_by_dates/1" do
    test "return a list of bookings between dates" do
      sut = BookingAgent.get_by_dates(~N[2021-06-10 00:00:00], ~N[2021-06-16 23:00:00])
      assert length(sut) == 2
      sut = BookingAgent.get_by_dates(~N[2021-06-10 00:00:00], ~N[2021-06-21 23:00:00])
      assert length(sut) == 3
    end

    test "return an empty list, when there is no booking in the interval" do
      assert BookingAgent.get_by_dates(~N[2021-06-22 00:00:00], ~N[2021-06-28 23:00:00])
             |> Enum.empty?()
    end
  end
end
