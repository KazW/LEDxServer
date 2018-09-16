defmodule LEDxServerWeb.API.DevicePinController do
  use LEDxServerWeb, :controller

  alias LEDxServer.API.DevicePins, as: API
  alias LEDxServer.Schemas.DevicePin

  action_fallback(LEDxServerWeb.API.FallbackController)

  def index(conn, _params) do
    device_pins = API.list_device_pins()
    render(conn, "index.json", device_pins: device_pins)
  end

  def create(conn, %{"device_pin" => device_pin_params}) do
    with {:ok, %DevicePin{} = device_pin} <- API.create_device_pin(device_pin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_device_pin_path(conn, :show, device_pin))
      |> render("show.json", device_pin: device_pin)
    end
  end

  def show(conn, %{"id" => id}) do
    device_pin = API.get_device_pin!(id)
    render(conn, "show.json", device_pin: device_pin)
  end

  def update(conn, %{"id" => id, "device_pin" => device_pin_params}) do
    device_pin = API.get_device_pin!(id)

    with {:ok, %DevicePin{} = device_pin} <- API.update_device_pin(device_pin, device_pin_params) do
      render(conn, "show.json", device_pin: device_pin)
    end
  end

  def delete(conn, %{"id" => id}) do
    device_pin = API.get_device_pin!(id)

    with {:ok, %DevicePin{}} <- API.delete_device_pin(device_pin) do
      send_resp(conn, :no_content, "")
    end
  end
end
