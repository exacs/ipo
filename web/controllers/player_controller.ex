defmodule Ipo.PlayerController do
  use Ipo.Web, :controller

  alias Ipo.Player
  alias Ipo.Team

  def index(conn, _params) do
    players = Repo.all(Player)
    render(conn, "index.html", players: players)
  end

  def new(conn, %{"team_id" => team_id}) do
    team = Repo.get!(Team, team_id)
    changeset = Player.changeset(%Player{})
    render(conn, "new_from_team.html", changeset: changeset, team: team)
  end

  def new(conn, _params) do
    changeset = Player.changeset(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"team_id" => team_id, "player" => player_params}) do
    team = Repo.get!(Team, team_id)
    params = Map.put(player_params, "team_id", team_id)
    changeset = Player.changeset(%Player{}, params)

    case Repo.insert(changeset) do
      {:ok, _player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, changeset} ->
        render(conn, "new_from_team.html", changeset: changeset, team: team)
    end
  end

  def create(conn, %{"player" => player_params}) do
    changeset = Player.changeset(%Player{}, player_params)

    case Repo.insert(changeset) do
      {:ok, _player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: player_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)
    render(conn, "show.html", player: player)
  end

  def edit(conn, %{"team_id" => team_id, "id" => id}) do
    team = Repo.get!(Team, team_id)
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player)
    render(conn, "edit_from_team.html", player: player, changeset: changeset, team: team)
  end

  def edit(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def update(conn, %{"team_id" => team_id, "id" => id, "player" => player_params}) do
    team = Repo.get!(Team, team_id)
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player, player_params)

    case Repo.update(changeset) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, changeset} ->
        render(conn, "edit_from_team.html", player: player, changeset: changeset, team: team)
    end
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player, player_params)

    case Repo.update(changeset) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: player_path(conn, :show, player))
      {:error, changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: player_path(conn, :index))
  end
end
