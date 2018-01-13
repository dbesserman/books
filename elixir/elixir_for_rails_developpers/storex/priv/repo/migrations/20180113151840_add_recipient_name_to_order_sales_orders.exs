defmodule Storex.Repo.Migrations.AddReceipientNameToOrderSalesOrders do
  use Ecto.Migration

  def change do
    alter table(:sales_orders) do
      add :receipient_name, :string
    end
  end
end
