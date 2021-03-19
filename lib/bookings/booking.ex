defmodule Flightex.Bookings.Booking do
  @keys [:id, :complete_date, :origin_city, :destination_city, :id_user]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, origin_city, destination_city, id_user) do
    %__MODULE__{
      id: UUID.uuid4(),
      complete_date: complete_date,
      origin_city: origin_city,
      destination_city: destination_city,
      id_user: id_user
    }
  end
end
