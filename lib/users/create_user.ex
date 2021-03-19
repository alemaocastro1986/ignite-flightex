defmodule Flightex.Users.CreateUser do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  alias Flightex.Users.Validation

  def call(%{name: name, email: email, cpf: cpf}) do
    with {:ok, user_email} <- Validation.validate_email(email),
         {:ok, user_cpf} <- Validation.validate_cpf(cpf) do
      User.build(name, user_email, user_cpf)
      |> save_user()
    end
  end

  def call(_params), do: {:error, "Invalid parameters."}

  defp save_user(%User{id: id} = user) do
    UserAgent.save(user)

    {:ok, id}
  end
end
