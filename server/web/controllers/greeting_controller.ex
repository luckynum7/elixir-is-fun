defmodule Chatty.GreetingController do
  use Chatty.Web, :controller

  # alias Chatty.Greeting

  def index(conn, _params) do
    # users = Repo.all(Greeting)
    # render(conn, "index.json", users: users)
    json(conn, _params)
  end

  # def create(conn, %{"greeting" => greeting_params}) do
  #   changeset = Greeting.changeset(%Greeting{}, greeting_params)

    #   case Repo.insert(changeset) do
  #     {:ok, greeting} ->
  #       conn
  #       |> put_status(:created)
  #       |> put_resp_header("location", greeting_path(conn, :show, greeting))
    #       |> render("show.json", greeting: greeting)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(Chatty.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   greeting = Repo.get!(Greeting, id)
  #   render(conn, "show.json", greeting: greeting)
  # end

  # def update(conn, %{"id" => id, "greeting" => greeting_params}) do
  #   greeting = Repo.get!(Greeting, id)
  #   changeset = Greeting.changeset(greeting, greeting_params)

    #   case Repo.update(changeset) do
  #     {:ok, greeting} ->
    #       render(conn, "show.json", greeting: greeting)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(Chatty.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   greeting = Repo.get!(Greeting, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(greeting)

  #   send_resp(conn, :no_content, "")
  # end
end
