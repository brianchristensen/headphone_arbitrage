defmodule InsightTest do
  use ExUnit.Case
  doctest Insight

  test "greets the world" do
    assert Insight.hello() == :world
  end
end
