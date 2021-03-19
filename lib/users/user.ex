defmodule Flightex.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) do
    %__MODULE__{id: UUID.uuid4(), name: name, email: email, cpf: cpf}
  end
end
