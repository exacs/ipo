defmodule Ipo.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :position, :integer
      add :tournament_id, references(:tournaments, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end
    create index(:participants, [:tournament_id])
    create index(:participants, [:team_id])

  end
end
