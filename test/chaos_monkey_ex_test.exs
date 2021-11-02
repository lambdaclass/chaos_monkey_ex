defmodule ChaosMonkeyExTest do
  use ExUnit.Case
  doctest ChaosMonkeyEx

  test "greets the world" do
    assert ChaosMonkeyEx.hello() == :world
  end
end
