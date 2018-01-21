defmodule Storex.Repo.Migrations.AddStatusToOrders do
  use Ecto.Migration

  def change do
    alter table(:sales_orders) do
      add :status, :string, default: "open"
    end
  end
end
