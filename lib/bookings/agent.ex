defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_params) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) when is_struct(booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))
  end

  def save(_params), do: {:error, "Invalid Booking struct"}

  def get(booking_id) do
    Agent.get(__MODULE__, &get_booking(&1, booking_id))
  end

  def get_by_dates(start_date, end_date) do
    Agent.get(__MODULE__, &get_date_interval(&1, start_date, end_date))
  end

  defp update_state(state, %Booking{id: id} = booking) do
    state
    |> Map.put(id, booking)
  end

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight booking not found."}
      booking -> {:ok, booking}
    end
  end

  defp get_date_interval(state, start_date, end_date) do
    state
    |> Map.values()
    |> Enum.filter(&between(&1, start_date, end_date))
  end

  defp between(%Booking{} = booking, from_date, to_date) do
    from_date = NaiveDateTime.compare(booking.complete_date, from_date)
    to_date = NaiveDateTime.compare(booking.complete_date, to_date)

    (from_date == :gt or from_date == :eq) and (to_date == :lt or to_date == :eq)
  end
end
