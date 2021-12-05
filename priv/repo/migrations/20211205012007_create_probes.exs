defmodule SpaceProbe.Repo.Migrations.CreateProbes do
  use Ecto.Migration

  def change do
    create table(:probes) do
      add :x, :integer
      add :y, :integer
      add :face, :string
      add :max_x, :integer
      add :max_y, :integer

      timestamps()
    end
  end
end
