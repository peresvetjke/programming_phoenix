defmodule AnnotationComponent do
  use Phoenix.Component

  def render("annotation.json", %{annotation: annotation}) do
    %{
      id: annotation.id,
      body: annotation.body,
      at: annotation.body,
      user: UserComponent.render("user.json", %{user: annotation.user})
    }
  end

  def render("annotation.json", %{annotations: annotations}) do
    %{annotations: Enum.map(annotations, fn a -> render("annotation.json", %{annotation: a}) end)}
  end
end
