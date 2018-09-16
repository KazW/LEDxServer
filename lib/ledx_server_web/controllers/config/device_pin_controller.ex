defmodule LEDxServerWeb.Config.DevicePinController do
  use LEDxServerWeb, :controller

  alias LEDxServer.Config.DevicePins, as: Config
  alias LEDxServer.Schemas.DevicePin

  def index(conn, %{"device_id" => device_id}) do
    device_pins = Config.list_device_pins(device_id)
    render(conn, "index.html", device_pins: device_pins, device_id: device_id)
  end

  def new(conn, %{"device_id" => device_id}) do
    changeset = Config.change_device_pin(%DevicePin{})
    render(conn, "new.html", changeset: changeset, device_id: device_id)
  end

  def create(conn, %{"device_pin" => device_pin_params, "device_id" => device_id}) do
    case Config.create_device_pin(device_pin_params) do
      {:ok, device_pin} ->
        conn
        |> put_flash(:info, "Device pin created successfully.")
        |> redirect(to: config_device_pin_path(conn, :show, device_id, device_pin))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, device_id: device_id)
    end
  end

  def show(conn, %{"id" => id, "device_id" => device_id}) do
    device_pin = Config.get_device_pin!(id)
    render(conn, "show.html", device_pin: device_pin, device_id: device_id)
  end

  def edit(conn, %{"id" => id, "device_id" => device_id}) do
    device_pin = Config.get_device_pin!(id)
    changeset = Config.change_device_pin(device_pin)
    render(conn, "edit.html", device_pin: device_pin, changeset: changeset, device_id: device_id)
  end

  def update(conn, %{"id" => id, "device_pin" => device_pin_params, "device_id" => device_id}) do
    device_pin = Config.get_device_pin!(id)

    case Config.update_device_pin(device_pin, device_pin_params) do
      {:ok, device_pin} ->
        conn
        |> put_flash(:info, "Device pin updated successfully.")
        |> redirect(to: config_device_pin_path(conn, :show, device_id, device_pin))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          device_pin: device_pin,
          changeset: changeset,
          device_id: device_id
        )
    end
  end

  def delete(conn, %{"id" => id, "device_id" => device_id}) do
    device_pin = Config.get_device_pin!(id)
    {:ok, _device_pin} = Config.delete_device_pin(device_pin)

    conn
    |> put_flash(:info, "Device pin deleted successfully.")
    |> redirect(to: config_device_pin_path(conn, :index, device_id))
  end
end
