defmodule RumblWeb.Layouts do
  use RumblWeb, :html
  import Phoenix.HTML.Form
  import RumblWeb.ErrorHelpers

  embed_templates("layouts/*")
end
