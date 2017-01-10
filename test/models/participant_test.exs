defmodule Ipo.ParticipantTest do
  use Ipo.ModelCase

  alias Ipo.Participant

  @valid_attrs %{position: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Participant.changeset(%Participant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Participant.changeset(%Participant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
