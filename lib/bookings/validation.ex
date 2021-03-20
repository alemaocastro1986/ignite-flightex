defmodule Flightex.Bookings.Validation do
  def validate_date(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, valid_date} -> {:ok, valid_date}
      {:error, error} -> {:error, "Datetime #{Atom.to_string(error)}"}
    end
  end
end
