defmodule RumblWeb.WatchController do
  use RumblWeb, :controller

  alias Rumbl.Repo
  alias Rumbl.RumblVideo.Video

  def show(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    render(conn, :show, video: video)
  end
end
