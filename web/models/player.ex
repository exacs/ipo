defmodule Ipo.Player do
  use Ipo.Web, :model

  schema "players" do
    field :name, :string
    belongs_to :team, Ipo.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :team_id])
    |> validate_required([:name, :team_id])
  end
end
