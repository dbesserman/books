defmodule StorexWeb.Plugs.ItemsTotalPrice do
  import Plug.Conn
  alias StorexWeb.Plugs
  alias Storex.Sales

  @assign_name :items_total_price

  def init(opts), do: opts

  def call(conn, _opts) do
    cart       = Plugs.Cart.get(conn)
    line_items = Sales.list_line_items(cart)
    total      = Sales.line_items_total_price(line_items)

    assign(conn, @assign_name, total)
  end

  def get(conn) do
    conn.assigns[@assign_name]
  end
end
