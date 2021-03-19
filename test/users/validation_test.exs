defmodule Flightex.Users.ValidationTest do
  use ExUnit.Case, async: true

  alias Flightex.Users.Validation

  describe "validate_email/1" do
    test "return a valid email" do
      assert {:ok, email} = Validation.validate_email("elixang@flightex.com")
      assert email == "elixang@flightex.com"
    end

    test "return an error, when invalid email" do
      assert {:error, "Invalid email"} = Validation.validate_email("invalid_email")
      assert {:error, "Invalid email"} = Validation.validate_email("@flightex.com")
      assert {:error, "Invalid email"} = Validation.validate_email("mix#flightex.com")
      assert {:error, "Invalid email"} = Validation.validate_email("mix@")
    end
  end

  describe "validate_cpf/1" do
    test "return a valid cpf" do
      assert {:ok, cpf} = Validation.validate_cpf("00854680814")
      assert cpf == "00854680814"
    end

    test "return an error, when invalid cpf" do
      assert {:error, "Invalid cpf"} = Validation.validate_cpf(99_854_680_814)
      assert {:error, "Invalid cpf"} = Validation.validate_cpf("008546808149")
      assert {:error, "Invalid cpf"} = Validation.validate_cpf("0085468081")
    end
  end
end
