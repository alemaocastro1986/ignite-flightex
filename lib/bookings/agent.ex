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
end
