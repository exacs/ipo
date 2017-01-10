defmodule Ipo.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :venue, :string
      add :date, :date
      add :official, :boolean, default: false, null: false
      add :sets, :integer
      add :points, :integer
      add :last_set, :integer
      add :timeouts, :integer

      timestamps()
    end

  end
end
