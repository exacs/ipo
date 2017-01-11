defmodule Ipo.TournamentController do
  use Ipo.Web, :controller

  alias Ipo.Tournament

  def index(conn, _params) do
    tournaments = Repo.all(Tournament)
    render(conn, "index.html", tournaments: tournaments)
  end

  def new(conn, _params) do
    changeset = Tournament.changeset(%Tournament{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tournament" => tournament_params}) do
    changeset = Tournament.changeset(%Tournament{}, tournament_params)

    case Repo.insert(changeset) do
      {:ok, _tournament} ->
        conn
        |> put_flash(:info, "Tournament created successfully.")
        |> redirect(to: tournament_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id) |> Repo.preload([:teams])
    render(conn, "show.html", tournament: tournament)
  end

  def edit(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id)
    changeset = Tournament.changeset(tournament)
    render(conn, "edit.html", tournament: tournament, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tournament" => tournament_params}) do
    tournament = Repo.get!(Tournament, id)
    changeset = Tournament.changeset(tournament, tournament_params)

    case Repo.update(changeset) do
      {:ok, tournament} ->
        conn
        |> put_flash(:info, "Tournament updated successfully.")
        |> redirect(to: tournament_path(conn, :show, tournament))
      {:error, changeset} ->
        render(conn, "edit.html", tournament: tournament, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tournament)

    conn
    |> put_flash(:info, "Tournament deleted successfully.")
    |> redirect(to: tournament_path(conn, :index))
  end
end
