defmodule Chatty.GreetingControllerTest do
  use Chatty.ConnCase

  alias Chatty.Greeting
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, greeting_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    greeting = Repo.insert! %Greeting{}
    conn = get conn, greeting_path(conn, :show, greeting)
    assert json_response(conn, 200)["data"] == %{"id" => greeting.id,
      "name" => greeting.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, greeting_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, greeting_path(conn, :create), greeting: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Greeting, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, greeting_path(conn, :create), greeting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    greeting = Repo.insert! %Greeting{}
    conn = put conn, greeting_path(conn, :update, greeting), greeting: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Greeting, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    greeting = Repo.insert! %Greeting{}
    conn = put conn, greeting_path(conn, :update, greeting), greeting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    greeting = Repo.insert! %Greeting{}
    conn = delete conn, greeting_path(conn, :delete, greeting)
    assert response(conn, 204)
    refute Repo.get(Greeting, greeting.id)
  end
end
