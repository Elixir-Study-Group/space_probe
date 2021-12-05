defmodule SpaceProbe.Probes do
  alias SpaceProbe.Probe

  @valid_instructions ["TL", "TR", "M"]

  def run_instructions(%Probe{} = probe, instructions) do
    if Enum.all?(instructions, &(&1 in @valid_instructions)) do
      changes = %{x: probe.x, y: probe.y, face: probe.face}

      Enum.reduce(instructions, {:ok, changes}, fn
        "M", {:ok, changes} -> move(changes,  probe.max_x, probe.max_y)
        direction, {:ok, changes} -> rotate(changes, direction)
        _, changes -> changes
      end)
    else
      {:error, "Invalid instructions"}
    end
  end

  defp move(%{face: "R"} = changes, max_x, _max_y) when changes.x + 1 <= max_x do
    {:ok, %{changes | x: changes.x + 1}}
  end

  defp move(%{face: "L"} = changes, _max_x, _max_y) when changes.x - 1 >= 0 do
    {:ok, %{changes | x: changes.x - 1}}
  end

  defp move(%{face: "U"} = changes, _max_x, max_y) when changes.y + 1 <= max_y do
    {:ok, %{changes | y: changes.y + 1}}
  end

  defp move(%{face: "B"} = changes, _max_x, _max_y) when changes.y - 1 >= 0 do
    {:ok, %{changes | y: changes.y - 1}}
  end

  defp move(_, _, _) do
    {:error, "Out of bounds"}
  end

  defp rotate(%{face: "R"} = changes, "TL"), do: {:ok, %{changes | face: "U"}}
  defp rotate(%{face: "L"} = changes, "TL"), do: {:ok, %{changes | face: "B"}}
  defp rotate(%{face: "U"} = changes, "TL"), do: {:ok, %{changes | face: "L"}}
  defp rotate(%{face: "B"} = changes, "TL"), do: {:ok, %{changes | face: "R"}}

  defp rotate(%{face: "R"} = changes, "TR"), do: {:ok, %{changes | face: "B"}}
  defp rotate(%{face: "L"} = changes, "TR"), do: {:ok, %{changes | face: "U"}}
  defp rotate(%{face: "U"} = changes, "TR"), do: {:ok, %{changes | face: "R"}}
  defp rotate(%{face: "B"} = changes, "TR"), do: {:ok, %{changes | face: "L"}}
end
