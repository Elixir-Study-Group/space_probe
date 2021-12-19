defmodule SpaceProbe.Probe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @valid_faces ["R", "L", "U", "B"]

  schema "probes" do
    field :face, :string, default: "R"
    field :max_x, :integer, default: 4
    field :max_y, :integer, default: 4
    field :x, :integer, default: 0
    field :y, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(probe, attrs) do
    max_x = Map.get(attrs, :max_x, probe.max_x)
    max_y = Map.get(attrs, :max_y, probe.max_y)

    probe
    |> cast(attrs, [:x, :y, :face, :max_x, :max_y])
    |> validate_required([:x, :y, :face, :max_x, :max_y])
    |> validate_number(:x, less_than: max_x, message: "must be less than max_x (%{number})")
    |> validate_number(:x, greater_than_or_equal_to: 0)
    |> validate_number(:y, less_than: max_y, message: "must be less than max_y (%{number})")
    |> validate_number(:y, greater_than_or_equal_to: 0)
    |> validate_face()
  end

  defp validate_face(%Changeset{valid?: false} = changeset) do
    changeset
  end

  defp validate_face(%Changeset{valid?: true} = changeset) do
    face = Map.get(changeset.changes, :face, changeset.data.face)

    if face in @valid_faces do
      changeset
    else
      add_error(changeset, :face, "must be in [%{valid_faces}]",
        valid_faces: Enum.join(@valid_faces, ", ")
      )
    end
  end
end
