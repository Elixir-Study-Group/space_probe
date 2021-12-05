defmodule SpaceProbe.ProbesTest do
  use SpaceProbe.DataCase, async: true
  alias SpaceProbe.Probes
  alias SpaceProbe.Probe

  describe "run_instructions/2" do
    test "if the instructions are empty" do
      instructions = []

      assert Probes.run_instructions(%Probe{}, instructions) == {:ok, %{x: 0, y: 0, face: "R"}}
    end

    test "if the instructions are possible" do
      instructions = ["TL", "M", "M", "M", "TR", "M", "M"]

      assert Probes.run_instructions(%Probe{}, instructions) == {:ok, %{x: 2, y: 3, face: "R"}}
    end

    test "if throws an error when the instructions are invalid" do
      instructions = ["GE"]

      assert Probes.run_instructions(%Probe{}, instructions) == {:error, "Invalid instructions"}
    end

    test "if throws an error when go out by y coordenate" do
      instructions = ["TR", "M"]

      assert Probes.run_instructions(%Probe{}, instructions) == {:error, "Out of bounds"}
    end

    test "if throws an error when go out by x coordenate" do
      instructions = ["M", "M", "M", "M", "M", "M"]

      assert Probes.run_instructions(%Probe{}, instructions) == {:error, "Out of bounds"}
    end
  end
end
