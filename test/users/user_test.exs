defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  describe "build/1" do
    test "return a user struct, when all parameters are valid." do
      assert %User{id: id, name: name, email: email, cpf: cpf} =
               User.build("Elixander Erlanguerson", "eli@flight.com", "36721119021")

      assert {:ok, _result} = UUID.info(id)
      assert name == "Elixander Erlanguerson"
      assert email == "eli@flight.com"
      assert cpf == "36721119021"
    end
  end
end
