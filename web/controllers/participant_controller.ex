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

  def matches_index(conn, %{"tournament_id" => tournament_id}) do
    tournament = Repo.get!(Tournament, tournament_id)
    |> Repo.preload([:participants])

    participants = tournament.participants
    |> Repo.preload([:team])

    changeset = Tournament.changeset(%Tournament{})

    positions = get_positions(participants |> length)

    render(
      conn,
      "matches_index.html",
      tournament: tournament,
      participants: participants,
      positions: positions,
      cross: Enum.zip(positions, participants),
      changeset: changeset
    )
  end

  def delete(conn, %{"id" => id, "tournament_id" => tournament_id}) do
    tournament = Repo.get!(Tournament, tournament_id)
    participant = Repo.get!(Participant, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(participant)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: tournament_path(conn, :show, tournament))
  end

  #####
  def get_positions(n) do
    pow2 = &(:math.pow(2, &1))
    m = :math.log2(n)
    |> Float.ceil
    |> pow2.()
    |> trunc

    case m do
      1 -> [1,2]
      2 -> [1,2]
      _ ->
        get_positions(div(m, 2))
        |> Enum.map(fn(i) -> [i, m+1-i] end)
        |> List.flatten
    end
  end
end
