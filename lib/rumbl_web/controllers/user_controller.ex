defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.{Repo, User}

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: ~p"/users")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
