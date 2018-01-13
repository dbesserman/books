defmodule StorexWeb.CheckoutController do
  use StorexWeb, :controller
  alias Storex.Sales
  alias StorexWeb.Plugs

  plug Plugs.EnsureCurrentUser

  def new(conn, _params) do
    changeset = Sales.new_order()

    conn
    |> with_cart_information()
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    cart = Plugs.Cart.get(conn)
    user = Plugs.CurrentUser.get(conn)

    case Sales.process_order(user, cart, order_params) do
      {:ok, _order} ->
        conn
        |> put_flash(:info, "Order successfully created. Thanks")
        |> Plugs.Cart.forget()
        |> redirect(to: book_path(conn, :index))
        |> halt()

      {:error, changeset} ->
        conn
        |> with_cart_information()
        |> render("new.html", changeset: changeset)
    end
  end

  defp with_cart_information(conn) do
    cart = Plugs.Cart.get(conn)
    items = Sales.list_line_items(cart)
    items_count = Sales.line_items_quantity_count(items)
    total_price = Sales.line_items_total_price(items)

    conn
    |> assign(:items_count, items_count)
    |> assign(:total_price, total_price)
  end
end
