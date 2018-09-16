defmodule LEDxServerWeb.Router do
  use LEDxServerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LEDxServerWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    scope "/", Config, as: :config do
      resources "/devices", DeviceController do
        resources("/pins", DevicePinController, as: :pin)
      end
    end
  end

  scope "/api", LEDxServerWeb.API, as: :api do
    pipe_through(:api)

    resources "/devices", DeviceController do
      resources("/pins", DevicePinController, as: :pin)
    end
  end
end
