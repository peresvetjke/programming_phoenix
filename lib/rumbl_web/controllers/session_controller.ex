defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  def new(conn, _) do
    render(conn, :new)
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/users")

      {:error, _reason, conn} ->
        conn |> put_flash(:error, "Invalid username/password combination") |> render(:new)
    end
  end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout()
    |> redirect(to: ~p"/")
  end
end
