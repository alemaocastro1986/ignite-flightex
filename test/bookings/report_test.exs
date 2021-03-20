defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report

  setup do
    BookingAgent.start_link(%{})

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

  describe "create_by_date/2" do
    test "return a message, when file is created" do
      assert {:ok, "Report generated successfully"} =
               Report.create_by_date(
                 "2021-06-01 08:00:00",
                 "2021-06-18 09:00:00"
               )
    end

    test "There is no data in this date range" do
      assert {:error, "There is no data in this date range"} =
               Report.create_by_date(
                 "2021-09-01 08:00:00",
                 "2021-09-18 09:00:00"
               )
    end
  end
end
