defmodule SpaceProbe.Probes do
  alias SpaceProbe.Probe

  @valid_instructions ["TL", "TR", "M"]

  def run_instructions(%Probe{} = probe, instructions) do
    run_instructions(probe, instructions, %{x: probe.x, y: probe.y, face: probe.face})
  end

  def run_instructions(_, _, {:error, _} = changes) do
    changes
  end

  def run_instructions(_, [], changes) do
    {:ok, changes}
  end

  def run_instructions(%Probe{} = probe, [instruction | instructions], changes) do
    cond do
      instruction not in @valid_instructions ->
        run_instructions(probe, [], {:error, "Invalid instructions"})

      instruction == "M" ->
        run_instructions(probe, instructions, move(changes, %{x: probe.max_x, y: probe.max_y}))

      instruction in ["TL", "TR"] ->
        run_instructions(probe, instructions, rotate(changes, instruction))
    end
  end

  defp move(%{face: "R"} = changes, max) when changes.x + 1 <= max.x do
    %{changes | x: changes.x + 1}
  end

  defp move(%{face: "L"} = changes, _max) when changes.x - 1 >= 0 do
    %{changes | x: changes.x - 1}
  end

  defp move(%{face: "U"} = changes, max) when changes.y + 1 <= max.y do
    %{changes | y: changes.y + 1}
  end

  defp move(%{face: "B"} = changes, _max) when changes.y - 1 >= 0 do
    %{changes | y: changes.y - 1}
  end

  defp move(_, _) do
    {:error, "Out of bounds"}
  end

  defp rotate(%{face: "R"} = changes, "TL"), do: %{changes | face: "U"}
  defp rotate(%{face: "L"} = changes, "TL"), do: %{changes | face: "B"}
  defp rotate(%{face: "U"} = changes, "TL"), do: %{changes | face: "L"}
  defp rotate(%{face: "B"} = changes, "TL"), do: %{changes | face: "R"}

  defp rotate(%{face: "R"} = changes, "TR"), do: %{changes | face: "B"}
  defp rotate(%{face: "L"} = changes, "TR"), do: %{changes | face: "U"}
  defp rotate(%{face: "U"} = changes, "TR"), do: %{changes | face: "R"}
  defp rotate(%{face: "B"} = changes, "TR"), do: %{changes | face: "L"}
end
