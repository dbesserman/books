defmodule StorexWeb.Router do
  use StorexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug StorexWeb.Plugs.Cart
    plug StorexWeb.Plugs.ItemsCount
    plug StorexWeb.Plugs.ItemsTotalPrice
    plug StorexWeb.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StorexWeb do
    pipe_through :browser

    get "/", BookController, :index

    resources "/books", BookController
    resources "/carts", CartController, singleton: true, only: [:show, :create, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
    resources "/checkout", CheckoutController, only: [:new, :create]
    resources "/orders", OrderController, only: [:index, :edit, :update]

    resources "/users", UserController, only: [:new, :create, :index] do
      resources "/admin", AdminController, only: [:create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", StorexWeb do
  #   pipe_through :api
  # end
end
