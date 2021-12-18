defmodule SpaceProbe.ProbeTest do
  use SpaceProbe.DataCase, async: true
  alias SpaceProbe.Probe

  describe "changeset/2" do
    test "if throws a error when x is greater than max_x" do
      changeset = Probe.changeset(%Probe{}, %{x: 2, max_x: 1})
      assert errors_on(changeset) == %{x: ["must be less than max_x (1)"]}
    end
  end
end
