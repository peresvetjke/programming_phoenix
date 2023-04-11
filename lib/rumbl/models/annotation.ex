defmodule Rumbl.Annotation do
  use Rumbl, :model

  import Ecto.Changeset

  schema "annotations" do
    field :at, :integer
    field :body, :string

    belongs_to :user, User
    belongs_to :video, Video

    timestamps()
  end

  @doc false
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
