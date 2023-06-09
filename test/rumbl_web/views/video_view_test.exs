defmodule Rumbl.VideoViewTest do
  use RumblWeb.ConnCase, async: true

  import Phoenix.Template

  alias Rumbl.RumblVideo.Video

  test "renders index.html", %{conn: conn} do
    videos = [
      %Video{id: "1", title: "dogs"},
      %Video{id: "2", title: "cats"}
    ]

    content = render_to_string(RumblWeb.VideoHTML, "index", "html", conn: conn, videos: videos)

    assert String.contains?(content, "Listing Videos")

    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Video.changeset(%Video{})
    categories = [{"cats", 123}]

    content =
      render_to_string(RumblWeb.VideoHTML, "new", "html",
        conn: conn,
        changeset: changeset,
        categories: categories
      )

    assert String.contains?(content, "New Video")
  end
end
