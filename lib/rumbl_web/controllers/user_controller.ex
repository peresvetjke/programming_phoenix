defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  def index(conn, _params) do
    users = Rumbl.Repo.all(Rumbl.User)
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Rumbl.Repo.get(Rumbl.User, id)
    render(conn, :show, user: user)
  end
end
