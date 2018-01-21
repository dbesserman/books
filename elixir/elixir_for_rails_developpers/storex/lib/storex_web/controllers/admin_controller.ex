defmodule StorexWeb.AdminController do
  use StorexWeb, :controller
  alias Storex.Accounts

  plug StorexWeb.Plugs.AdminOnly when action in [:create]

  def create(conn, %{"user_id" => user_id}) do
    user = Accounts.get_user!(user_id)

    case Accounts.mark_as_admin(user) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "#{user.full_name} is now an administrator")
        |> redirect(to: user_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: user_path(conn, :index))
    end
  end
end
