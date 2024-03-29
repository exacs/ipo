defmodule Ipo.Team do
  use Ipo.Web, :model

  schema "teams" do
    field :name, :string
    has_many :players, Ipo.Player

    many_to_many :tournaments, Ipo.Tournament, join_through: Ipo.Participant

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
