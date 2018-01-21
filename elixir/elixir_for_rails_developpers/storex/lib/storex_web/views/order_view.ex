defmodule StorexWeb.OrderView do
  use StorexWeb, :view

  def statuses() do
    Storex.Sales.order_statuses
  end
end
