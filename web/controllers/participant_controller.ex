defmodule Ipo.ParticipantController do
  use Ipo.Web, :controller

  alias Ipo.Tournament
  alias Ipo.Participant

  def teams_index(conn, %{"tournament_id" => tournament_id}) do
    tournament = Repo.get!(Tournament, tournament_id) |> Repo.preload([:teams])
    render(conn, "teams_index.html", tournament: tournament)
  end

  def teams_new(conn, %{"tournament_id" => tournament_id}) do
    tournament = Repo.get!(Tournament, tournament_id)
    changeset = Participant.changeset(%Participant{})
    render(conn, "teams_new.html", changeset: changeset, tournament: tournament)
  end

  def teams_create(conn, %{"tournament_id" => tournament_id, "participant" => participant_params}) do
    tournament = Repo.get!(Tournament, tournament_id)
    params = Map.put(participant_params, "tournament_id", tournament_id)
    changeset = Participant.changeset(%Participant{}, params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Participant added successfully")
        |> redirect(to: tournament_participant_path(conn, :teams_index, tournament))
      {:error, changeset} ->
        render(conn, "teams_new.html", changeset: changeset, tournament: tournament)
    end
  end

  def matches_index(conn, _params) do
  end
end
