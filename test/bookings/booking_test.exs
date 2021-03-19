defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/1" do
    test "return a booking struct" do
      assert %Booking{
               complete_date: complete_date,
               origin_city: origin,
               destination_city: destination,
               id_user: user_id
             } =
               Booking.build(
                 ~N[2021-04-10 08:00:59],
                 "Brazil",
                 "Italy",
                 "3b15f542-cd22-424f-ba86-921661506675"
               )

      assert complete_date == ~N[2021-04-10 08:00:59]
      assert origin == "Brazil"
      assert destination == "Italy"
      assert user_id == "3b15f542-cd22-424f-ba86-921661506675"
    end
  end
end
