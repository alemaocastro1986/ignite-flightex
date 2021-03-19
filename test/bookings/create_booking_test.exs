defmodule Flightex.Bookings.CreateBookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.{Booking, CreateBooking}
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Flightex.start_links()

      build(:user)
      |> UserAgent.save()

      :ok
    end

    test "return a new flight booking, when all parameters is valid" do
      assert {:ok, _uuid} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74490", %{
                 complete_date: "2021-04-10 08:00:11",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })
    end

    test "return an error, when id format is invalid" do
      assert {:error, "Invalid UUID"} =
               CreateBooking.call("invalid_uuid", %{
                 complete_date: "2021-04-10 08:00:11",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })
    end

    test "return an error, when complete_date is invalid" do
      assert {:error, "Datetime invalid_format"} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74490", %{
                 complete_date: "2021-04-10 08:00",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })

      assert {:error, "Datetime invalid_time"} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74490", %{
                 complete_date: "2021-04-10 08:00:60",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })

      assert {:error, "Datetime invalid_date"} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74490", %{
                 complete_date: "2021-04-32 08:00:00",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })

      assert {:error, "Datetime invalid_format"} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74490", %{
                 complete_date: "2021-04-10",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })
    end

    test "return an error, when user not exists" do
      assert {:error, "User not found"} =
               CreateBooking.call("a5749ea1-2c29-4f12-b2cc-659811f74491", %{
                 complete_date: "2021-04-10 08:00:00",
                 origin_city: "Brazil",
                 destination_city: "Italy"
               })
    end
  end
end
