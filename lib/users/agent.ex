defmodule Flightex.Users.Agent do
  use Agent
  alias Flightex.Users.User

  def start_link(_params) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) when is_struct(user) do
    Agent.update(__MODULE__, &update_state(&1, user))
  end

  def save(_params), do: {:error, "Invalid parameters."}

  def get(id) do
    Agent.get(__MODULE__, &get_user(&1, id))
  end

  defp update_state(state, %User{id: id} = user) do
    state
    |> Map.put(id, user)
  end

  defp get_user(state, user_id) do
    case Map.get(state, user_id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
