defmodule SpaceProbe.Probe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "probes" do
    field :face, :string, default: "R"
    field :max_x, :integer, default: 4
    field :max_y, :integer, default: 4
    field :x, :integer, default: 0
    field :y, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(probe, %{max_x: max_x}=attrs) do
    probe
    |> cast(attrs, [:x, :y, :face, :max_x, :max_y])
    |> validate_required([:x, :y, :face, :max_x, :max_y])
    |> validate_number(:x, less_than: max_x, message: "must be less than max_x (%{number})")
  end
end
