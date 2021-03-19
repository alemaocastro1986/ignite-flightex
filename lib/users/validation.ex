defmodule Flightex.Users.Validation do
  @email_pattern ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i

  def validate_email(email) when is_binary(email) do
    case Regex.run(@email_pattern, email) do
      nil -> {:error, "Invalid email"}
      _ -> {:ok, email}
    end
  end

  def validate_cpf(cpf) do
    case is_bitstring(cpf) and String.length(cpf) == 11 do
      false -> {:error, "Invalid cpf"}
      _ -> {:ok, cpf}
    end
  end
end
