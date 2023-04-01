defmodule Rumbl.RumblVideo.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(url title description)a
  @optional_fields ~w()a

  schema "videos" do
    field(:description, :string)
    field(:title, :string)
    field(:url, :string)
    belongs_to(:user, Rumbl.User)

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
