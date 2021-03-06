defmodule StorexWeb.Plugs.CurrentUser do
  import Plug.Conn
  alias Storex.Accounts

  @session_name :user_id
  @assign_name :current_user


  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, @session_name)

    cond do
      user = user_id && Accounts.get_user!(user_id) ->
        assign_user(conn, user)
      true -> assign_user(conn, nil)
    end
  end

  def assign_user(conn, user) do
    conn
    |> assign(@assign_name, user)
    |> assign(:is_admin, admin?(user))
  end

  def set(conn, user) do
    conn
    |> put_session(@session_name, user.id)
    |> assign_user(user)
  end

  def forget(conn) do
    conn
    |> delete_session(@session_name)
    |> delete_session(@assign_name)
  end

  def get(conn), do: conn.assigns[@assign_name]

  def admin?(%Plug.Conn{}=conn) do
    user = get(conn)
    admin?(user)
  end

  def admin?(user) do
    user && user.is_admin
  end
end
