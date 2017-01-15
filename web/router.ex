defmodule Ipo.Router do
  use Ipo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ipo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/players", PlayerController
    resources "/teams", TeamController do
      resources "/players", PlayerController, only: [:new, :create, :edit, :update]
    end

    resources "/tournaments", TournamentController do
      get "/teams", ParticipantController, :teams_index
      get "/teams/:team_id", ParticipantController, :teams_show
      get "/teams/new", ParticipantController, :teams_new
      post "/teams/", ParticipantController, :teams_create
      get "/matches", ParticipantController, :matches_index
      resources "/teams", ParticipantController, only: [:delete]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ipo do
  #   pipe_through :api
  # end
end
