defmodule Ipo.Repo.Migrations.PlayersOfTeams do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :team_id, references(:teams)
    end
  end
end
