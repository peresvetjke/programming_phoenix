defmodule Rumbl.RumblVideo.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(url title description)a
  @optional_fields ~w(category_id)a

  @primary_key {:id, Rumbl.Permalink, autogenerate: true}
  schema "videos" do
    field(:description, :string)
    field(:title, :string)
    field(:url, :string)
    field(:slug, :string)

    belongs_to(:user, Rumbl.User)
    belongs_to(:category, Rumbl.Category)
    has_many :annotations, Rumbl.Annotation

    timestamps()
  end

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> slugify_title()
    |> assoc_constraint(:category)
  end

  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  defimpl Phoenix.Param, for: Rumbl.RumblVideo.Video do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
end
