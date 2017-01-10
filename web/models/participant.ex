defmodule Ipo.Participant do
  use Ipo.Web, :model

  schema "participants" do
    field :position, :integer
    belongs_to :tournament, Ipo.Tournament
    belongs_to :team, Ipo.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:position])
    |> validate_required([:position])
  end
end
