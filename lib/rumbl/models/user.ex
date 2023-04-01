defmodule Rumbl.User do
  use Rumbl, :model

  schema "users" do
    field(:name, :string)
    field(:username, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  def changeset(user, %{} = params \\ %{}) do
    user
    |> cast(params, ~w(name username)a)
    |> validate_length(:username, min: 3, max: 30)
    |> unique_constraint(:username)
  end
end
