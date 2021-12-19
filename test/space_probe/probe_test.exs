defmodule SpaceProbe.ProbeTest do
  use SpaceProbe.DataCase, async: true
  alias SpaceProbe.Probe

  describe "changeset/2" do
    test "if throws a error when x is greater than max_x" do
      changeset = Probe.changeset(%Probe{}, %{x: 2, max_x: 1})
      assert errors_on(changeset) == %{x: ["must be less than max_x (1)"]}
    end

    test "if throws a error when x is less than 0" do
      changeset = Probe.changeset(%Probe{}, %{x: -1})
      assert errors_on(changeset) == %{x: ["must be greater than or equal to 0"]}
    end

    test "if throws a error when y is greater than max_y" do
      changeset = Probe.changeset(%Probe{}, %{y: 2, max_y: 1})
      assert errors_on(changeset) == %{y: ["must be less than max_y (1)"]}
    end

    test "if throws a error when y is less than 0" do
      changeset = Probe.changeset(%Probe{}, %{y: -1})
      assert errors_on(changeset) == %{y: ["must be greater than or equal to 0"]}
    end
  end
end
