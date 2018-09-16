defmodule LEDxServerWeb.Config.DeviceController do
  use LEDxServerWeb, :controller

  alias LEDxServer.Config.Devices, as: Config
  alias LEDxServer.Schemas.Device

  def index(conn, _params) do
    devices = Config.list_devices()
    render(conn, "index.html", devices: devices)
  end

  def new(conn, _params) do
    changeset = Config.change_device(%Device{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"device" => device_params}) do
    case Config.create_device(device_params) do
      {:ok, device} ->
        conn
        |> put_flash(:info, "Device created successfully.")
        |> redirect(to: config_device_path(conn, :show, device))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    device = Config.get_device!(id)
    render(conn, "show.html", device: device)
  end

  def edit(conn, %{"id" => id}) do
    device = Config.get_device!(id)
    changeset = Config.change_device(device)
    render(conn, "edit.html", device: device, changeset: changeset)
  end

  def update(conn, %{"id" => id, "device" => device_params}) do
    device = Config.get_device!(id)

    case Config.update_device(device, device_params) do
      {:ok, device} ->
        conn
        |> put_flash(:info, "Device updated successfully.")
        |> redirect(to: config_device_path(conn, :show, device))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", device: device, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    device = Config.get_device!(id)
    {:ok, _device} = Config.delete_device(device)

    conn
    |> put_flash(:info, "Device deleted successfully.")
    |> redirect(to: config_device_path(conn, :index))
  end
end
