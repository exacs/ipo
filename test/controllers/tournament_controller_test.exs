defmodule Ipo.TournamentControllerTest do
  use Ipo.ConnCase

  alias Ipo.Tournament
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, last_set: 42, name: "some content", official: true, points: 42, sets: 42, timeouts: 42, venue: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tournament_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tournaments"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tournament_path(conn, :new)
    assert html_response(conn, 200) =~ "New tournament"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tournament_path(conn, :create), tournament: @valid_attrs
    assert redirected_to(conn) == tournament_path(conn, :index)
    assert Repo.get_by(Tournament, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tournament_path(conn, :create), tournament: @invalid_attrs
    assert html_response(conn, 200) =~ "New tournament"
  end

  test "shows chosen resource", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = get conn, tournament_path(conn, :show, tournament)
    assert html_response(conn, 200) =~ "Show tournament"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tournament_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = get conn, tournament_path(conn, :edit, tournament)
    assert html_response(conn, 200) =~ "Edit tournament"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = put conn, tournament_path(conn, :update, tournament), tournament: @valid_attrs
    assert redirected_to(conn) == tournament_path(conn, :show, tournament)
    assert Repo.get_by(Tournament, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = put conn, tournament_path(conn, :update, tournament), tournament: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tournament"
  end

  test "deletes chosen resource", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = delete conn, tournament_path(conn, :delete, tournament)
    assert redirected_to(conn) == tournament_path(conn, :index)
    refute Repo.get(Tournament, tournament.id)
  end
end
