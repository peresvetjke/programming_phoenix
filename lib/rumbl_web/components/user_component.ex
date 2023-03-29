defmodule UserComponent do
  use Phoenix.Component

  def show(assigns) do
    ~H"""
    <span><%= @user.name %> (<%= @user.username %> / <%= @user.id %>)</span>
    """
  end
end
