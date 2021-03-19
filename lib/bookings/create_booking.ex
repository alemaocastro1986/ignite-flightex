defmodule Flightex.Bookings.CreateBooking do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  alias Flightex.Users.Agent, as: UserAgent

  def call(user_id, %{
        complete_date: date,
        origin_city: origin_city,
        destination_city: destination_city
      }) do
    with {:ok, id} <- validate_id(user_id),
         {:ok, complete_date} <- validate_date(date),
         {:ok, user} <- UserAgent.get(id) do
      Booking.build(complete_date, origin_city, destination_city, user.id)
      |> save_booking()
    else
      {:error, _reason} = error -> error
    end
  end

  def save_booking(%Booking{id: id} = booking) do
    BookingAgent.save(booking)
    {:ok, id}
  end

  defp validate_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, valid_date} -> {:ok, valid_date}
      {:error, error} -> {:error, "Datetime #{Atom.to_string(error)}"}
    end
  end

  defp validate_id(id) do
    case UUID.info(id) do
      {:ok, _result} -> {:ok, id}
      {:error, _reason} -> {:error, "Invalid UUID"}
    end
  end
end
