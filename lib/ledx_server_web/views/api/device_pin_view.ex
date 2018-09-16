defmodule LEDxServerWeb.API.DevicePinView do
  use LEDxServerWeb, :view
  alias LEDxServerWeb.API.DevicePinView

  def render("index.json", %{device_pins: device_pins}) do
    %{data: render_many(device_pins, DevicePinView, "device_pin.json")}
  end

  def render("show.json", %{device_pin: device_pin}) do
    %{data: render_one(device_pin, DevicePinView, "device_pin.json")}
  end

  def render("device_pin.json", %{device_pin: device_pin}) do
    %{
      id: device_pin.id,
      name: device_pin.name,
      pin: device_pin.pin,
      led_count: device_pin.led_count
    }
  end
end
