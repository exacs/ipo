defmodule Ipo.Tournament do
  use Ipo.Web, :model

  schema "tournaments" do
    field :name, :string
    field :venue, :string
    field :date, Ecto.Date
    field :official, :boolean, default: false
    field :sets, :integer
    field :points, :integer
    field :last_set, :integer
    field :timeouts, :integer

    has_many :participants, Ipo.Participant
    many_to_many :teams, Ipo.Team, join_through: Ipo.Participant

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :venue, :date, :official, :sets, :points, :last_set, :timeouts])
    |> validate_required([:name, :venue, :date, :official, :sets, :points, :last_set, :timeouts])
  end
end
