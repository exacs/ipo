defmodule Ipo.TournamentTest do
  use Ipo.ModelCase

  alias Ipo.Tournament

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, last_set: 42, name: "some content", official: true, points: 42, sets: 42, timeouts: 42, venue: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tournament.changeset(%Tournament{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tournament.changeset(%Tournament{}, @invalid_attrs)
    refute changeset.valid?
  end
end
