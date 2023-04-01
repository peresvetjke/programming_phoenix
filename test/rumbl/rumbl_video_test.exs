defmodule Rumbl.RumblVideoTest do
  use Rumbl.DataCase

  alias Rumbl.RumblVideo

  describe "videos" do
    alias Rumbl.RumblVideo.Video

    import Rumbl.RumblVideoFixtures

    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert RumblVideo.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert RumblVideo.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      valid_attrs = %{description: "some description", title: "some title", url: "some url"}

      assert {:ok, %Video{} = video} = RumblVideo.create_video(valid_attrs)
      assert video.description == "some description"
      assert video.title == "some title"
      assert video.url == "some url"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RumblVideo.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", url: "some updated url"}

      assert {:ok, %Video{} = video} = RumblVideo.update_video(video, update_attrs)
      assert video.description == "some updated description"
      assert video.title == "some updated title"
      assert video.url == "some updated url"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = RumblVideo.update_video(video, @invalid_attrs)
      assert video == RumblVideo.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = RumblVideo.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> RumblVideo.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = RumblVideo.change_video(video)
    end
  end
end
