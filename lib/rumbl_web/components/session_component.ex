defmodule SessionComponent do
  use Phoenix.Component
  import Phoenix.HTML.Form
  import RumblWeb.ErrorHelpers

  def form(assigns) do
    ~H"""
    <%= form_for @conn, "/sessions", [as: :session], fn f -> %>
      <div class="form-group">
        <%= text_input f, :username, placeholder: "Username", class: "form-control" %>
      </div>

      <div class="form-group">
        <%= password_input f, :password, placeholder: "Password", class: "form-control" %>
      </div>

      <%= submit "Log in", class: "btn btn-primary" %>
    <% end %>
    """
  end
end
