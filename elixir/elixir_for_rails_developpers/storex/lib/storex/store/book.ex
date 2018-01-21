defmodule Storex.Store.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Store.Book

  schema "store_books" do
    # Ecto requires to explicitely define all the database fields you wish to map
    field :description, :string
    field :image_url, :string
    field :price, :decimal
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    # transforms external parameters into an Ecto changeset
    book
    |> cast(attrs, [:id, :title, :description, :price, :image_url])
    |> validate_required([:title, :description, :price, :image_url])
    # |> validate_max_price()
  end

  def validate_max_price(changeset) do
    price = get_change(changeset, :price)
    if Decimal.cmp(price, Decimal.div(Decimal.new(9999), Decimal.new(100))) == :gt do
      add_error(changeset, :price, "Price is not valid")
    end
  end
end
