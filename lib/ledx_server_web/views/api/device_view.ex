defmodule LEDxServerWeb.API.DeviceView do
  use LEDxServerWeb, :view
  alias LEDxServerWeb.API.DeviceView
  alias LEDxServerWeb.API.DevicePinView, as: PinView

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{
      id: device.id,
      name: device.name,
      hardware_id: device.hardware_id,
      powered_on: device.powered_on,
      pins: render_many(device.pins, PinView, "device_pin.json", as: :device_pin),
      last_update:
        device.updated_at
        |> NaiveDateTime.to_erl()
        |> :calendar.datetime_to_gregorian_seconds()
        |> Kernel.-(62_167_219_200)
    }
  end
end
