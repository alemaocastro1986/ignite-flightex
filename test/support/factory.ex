defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: "a5749ea1-2c29-4f12-b2cc-659811f74490",
      name: "John Doe",
      email: "jd@flightex.com",
      cpf: "36721119021"
    }
  end

  def booking_factory do
    user = build(:user)

    %Booking{
      id: "4fbab03b-ffeb-41d4-8718-5ec5e29971f7",
      complete_date: ~N[2021-04-10 00:00:00],
      origin_city: "Brazil",
      destination_city: "transylvania",
      id_user: user.id
    }
  end
end
