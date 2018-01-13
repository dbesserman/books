defmodule StorexWeb.Plugs.EnsureCurrentUser do
  alias StorexWeb.Plugs
  alias StorexWeb.Router.Helpers
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if Plugs.CurrentUser.get(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Sign in or Sign up before you continue")
      |> redirect(to: Helpers.user_path(conn, :new))
    end
  end
end
