defmodule Chatty.GreetingView do
  use Chatty.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Chatty.GreetingView, "greeting.json")}
  end

  def render("show.json", %{greeting: greeting}) do
    %{data: render_one(greeting, Chatty.GreetingView, "greeting.json")}
  end

  def render("greeting.json", %{greeting: greeting}) do
    %{id: greeting.id,
      name: greeting.name}
  end
end
