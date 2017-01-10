defmodule Ipo.Participant do
  use Ipo.Web, :model

  schema "participants" do
    field :position, :integer, default: 0
    belongs_to :tournament, Ipo.Tournament
    belongs_to :team, Ipo.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:position, :tournament_id, :team_id])
    |> validate_required([:tournament_id, :team_id])
  end
end
