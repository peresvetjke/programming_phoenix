defmodule RumblWeb.VideoController do
  use RumblWeb, :controller
  import Ecto, only: [assoc: 2, build_assoc: 2]

  alias Rumbl.{Category, Repo, RumblVideo}
  alias Rumbl.RumblVideo.Video

  plug(:load_categories when action in [:new, :create, :edit, :update])

  def index(conn, _params, user) do
    videos = Repo.all(user_videos(user))
    render(conn, :index, videos: videos)
  end

  def new(conn, _params, user) do
    changeset = user |> build_assoc(:videos) |> Video.changeset()

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    changeset =
      user
      |> build_assoc(:videos)
      |> Video.changeset(video_params)

    case Repo.insert(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: ~p"/manage/videos/#{video}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    video = Repo.get!(user_videos(user), id)
    render(conn, :show, video: video)
  end

  def edit(conn, %{"id" => id}, user) do
    video = Repo.get!(user_videos(user), id)
    changeset = Video.changeset(video)
    render(conn, :edit, video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, user) do
    video = Repo.get!(user_videos(user), id)
    changeset = Video.changeset(video, video_params)

    case RumblVideo.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: ~p"/manage/videos/#{video}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    video = Repo.get!(RumblVideo.list_user_videos(user), id)
    {:ok, _video} = RumblVideo.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: ~p"/manage/videos")
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def user_videos(user) do
    assoc(user, :videos)
  end

  defp load_categories(conn, _) do
    query =
      Category
      |> Category.alphabetical()
      |> Category.names_and_ids()

    categories = Repo.all(query)
    assign(conn, :categories, categories)
  end
end
