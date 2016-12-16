defmodule Chatty.Router do
  use Chatty.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Chatty do
    pipe_through :api
  end
end
