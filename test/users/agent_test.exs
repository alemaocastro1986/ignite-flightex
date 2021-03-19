defmodule Flightex.Users.AgentTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  setup do
    UserAgent.start_link(%{})

    build(:user, id: "3782a1af-84a4-4157-8946-0d51c0ea6b34")
    |> UserAgent.save()

    :ok
  end

  describe "save/1" do
    test "return :ok , when user is saved" do
      user = build(:user, id: "3782a1af-84a4-4157-8946-0d51c0ea6b34")
      assert :ok = UserAgent.save(user)
      assert {:ok, %User{}} = UserAgent.get("3782a1af-84a4-4157-8946-0d51c0ea6b34")
    end

    test "return an error, when parameter is inavlid" do
      assert {:error, "Invalid parameters."} = UserAgent.save(%{})
    end
  end

  describe "get/1" do
    test "return a user" do
      assert {:ok, %User{}} = UserAgent.get("3782a1af-84a4-4157-8946-0d51c0ea6b34")
    end

    test "return an error, when user not exists" do
      assert {:error, "User not found"} = UserAgent.get("3782a1af-84a4-4157-8950-0d51c0ea6b34")
    end
  end
end
