require IEx

defmodule LEDxServerWeb.API.DeviceController do
  use LEDxServerWeb, :controller

  alias LEDxServer.Repo
  alias LEDxServer.API.Devices, as: API
  alias LEDxServer.Schemas.Device

  action_fallback(LEDxServerWeb.API.FallbackController)

  def index(conn, _params) do
    devices = API.list_devices() |> Enum.map(&preload_assoc/1)
    render(conn, "index.json", devices: devices)
  end

  def create(conn, %{"device" => device_params} = params) do
    # def create(conn, params) do
    # IEx.pry
    # device_params = %{}
    with {:ok, %Device{} = device} <- API.create_device(device_params) do
      device = device |> preload_assoc

      conn
      |> put_status(:created)
      |> put_resp_header("location", api_device_path(conn, :show, device))
      |> render("show.json", device: device)
    end
  end

  def show(conn, %{"id" => id}) do
    device = API.get_device!(id) |> preload_assoc
    render(conn, "show.json", device: device)
  end

  def update(conn, %{"id" => id, "device" => device_params}) do
    device = API.get_device!(id)

    with {:ok, %Device{} = device} <- API.update_device(device, device_params) do
      device = device |> preload_assoc
      render(conn, "show.json", device: device)
    end
  end

  def delete(conn, %{"id" => id}) do
    device = API.get_device!(id)

    with {:ok, %Device{}} <- API.delete_device(device) do
      send_resp(conn, :no_content, "")
    end
  end

  defp preload_assoc(device), do: device |> Repo.preload(:pins)
end
