defmodule Bookavoy.Router do
  use Bookavoy.Web, :router

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

  scope "/", Bookavoy do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Bookavoy do
  #   pipe_through :api
  # end
  
   scope "/api/slack", Bookavoy do
     pipe_through :api

     post "/slash", SlackController, :slash
     post "/message-button", SlackController, :message_button
   end
end
