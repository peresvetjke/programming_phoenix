defmodule UserComponent do
  use Phoenix.Component
  import Phoenix.HTML.Form
  import RumblWeb.ErrorHelpers

  def show(assigns) do
    ~H"""
    <span><%= @user.name %> (<%= @user.username %> / <%= @user.id %>)</span>
    """
  end

  def form(assigns) do
    ~H"""
    <%= if @changeset.action do %>
      <div class="alert alert-danger">
        <p>Oops, something went wrong! Please check the errors below.</p>
      </div>
    <% end %>

    <%= form_for @changeset, "/users", fn f -> %>
      <div class="form-group">
        <%= text_input(f, :name, placeholder: "Name", class: "form-control") %>
        <%= error_tag(f, :name) %>
      </div>
      <div class="form-group">
        <%= text_input(f, :username, placeholder: "Username", class: "form-control") %>
        <%= error_tag(f, :username) %>
      </div>
      <div class="form-group">
        <%= password_input(f, :password,
          placeholder: "Password",
          class: "form-control"
        ) %>
        <%= error_tag(f, :password) %>
      </div>
      <%= submit("Create User", class: "btn btn-primary") %>
    <% end %>
    """
  end
end
