defmodule Storex.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.Order


  schema "sales_orders" do
    belongs_to :user, Storex.Accounts.User
    has_many :line_items, Storex.Sales.LineItem

    field :address, :string
    field :receipient_name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:address, :receipient_name, :status])
    |> validate_required([:address])
  end

  def statuses do
    ["open", "dispatched", "canceled"]
  end
end
