defmodule Flightex.Users.CreateUserTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateUser

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "return a user id, when all parameters is valid" do
      user_params = %{
        name: "Elix Pipe",
        email: "pipe@flightex.com",
        cpf: "82483741061"
      }

      assert {:ok, id} = CreateUser.call(user_params)
      assert {:ok, _result} = UUID.info(id)
    end

    test "return an error, when invalid parameters" do
      assert {:error, "Invalid parameters."} = CreateUser.call(%{})
    end

    test "return an error, when invalid email" do
      user_params = %{
        name: "Elix Pipe",
        email: "pipe#flightex.com",
        cpf: "82483741061"
      }

      assert {:error, "Invalid email"} = CreateUser.call(user_params)
    end

    test "return an error, when invalid cpf" do
      user_params = %{
        name: "Elix Pipe",
        email: "pipe@flightex.com",
        cpf: 82_483_741_061
      }

      assert {:error, "Invalid cpf"} = CreateUser.call(user_params)
    end
  end
end
