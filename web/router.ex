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
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ipo do
  #   pipe_through :api
  # end
end
