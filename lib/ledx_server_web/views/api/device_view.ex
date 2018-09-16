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
      pins: render_many(device.pins, PinView, "device_pin.json", as: :device_pin)
    }
  end
end
