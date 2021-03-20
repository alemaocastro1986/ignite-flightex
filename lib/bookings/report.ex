defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.{Booking, Validation}

  def create_by_date(from, to) do
    with {:ok, from_date} <- Validation.validate_date(from),
         {:ok, to_date} <- Validation.validate_date(to) do
      BookingAgent.get_by_dates(from_date, to_date)
      |> Enum.map(&parse_row(&1))
      |> build_csv()
    end
  end

  defp parse_row(%Booking{
         id_user: user_id,
         origin_city: origin_city,
         destination_city: destination_city,
         complete_date: complete_date
       }) do
    "#{user_id};#{origin_city};#{destination_city};#{NaiveDateTime.to_string(complete_date)}\n"
  end

  defp build_csv(content) when length(content) > 0 do
    case File.write("reports/flight_booking_report.csv", content) do
      {:error, _reason} -> {:error, "Report not created"}
      _ -> {:ok, "Report generated successfully"}
    end
  end

  defp build_csv(_content), do: {:error, "There is no data in this date range"}
end
