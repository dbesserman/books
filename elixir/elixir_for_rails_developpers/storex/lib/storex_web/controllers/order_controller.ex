defmodule StorexWeb.OrderController do
  use StorexWeb, :controller
  alias Storex.Sales

  plug StorexWeb.Plugs.AdminOnly when action in [:index]

  def index(conn, _params) do
    render conn, "index.html", orders: Sales.list_orders()
  end

  def edit(conn, %{"id" => order_id}) do
    order     = Sales.get_order(order_id)
    changeset = Sales.change_order(order)

    render conn, "edit.html", changeset: changeset, order: order
  end

  def update(conn, %{"id" => order_id, "order" => order_params}) do
    order     = Sales.get_order(order_id)

    case Sales.update_order(order, order_params) do
      {:ok, _order} ->
        conn
        |> put_flash(:info, "Order updated")
        |> redirect(to: "/")
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset
    end
  end
end
