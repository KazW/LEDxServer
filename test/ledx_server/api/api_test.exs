defmodule LEDxServer.APITest do
  use LEDxServer.DataCase

  alias LEDxServer.API

  describe "devices" do
    alias LEDxServer.API.Device

    @valid_attrs %{active: true, device_id: 42, name: "some name"}
    @update_attrs %{active: false, device_id: 43, name: "some updated name"}
    @invalid_attrs %{active: nil, device_id: nil, name: nil}

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_device()

      device
    end

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      assert API.list_devices() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert API.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = API.create_device(@valid_attrs)
      assert device.active == true
      assert device.device_id == 42
      assert device.name == "some name"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, device} = API.update_device(device, @update_attrs)
      assert %Device{} = device
      assert device.active == false
      assert device.device_id == 43
      assert device.name == "some updated name"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_device(device, @invalid_attrs)
      assert device == API.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = API.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> API.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = API.change_device(device)
    end
  end

  describe "device_pins" do
    alias LEDxServer.API.DevicePin

    @valid_attrs %{led_count: 42, name: "some name", pin: 42}
    @update_attrs %{led_count: 43, name: "some updated name", pin: 43}
    @invalid_attrs %{led_count: nil, name: nil, pin: nil}

    def device_pin_fixture(attrs \\ %{}) do
      {:ok, device_pin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_device_pin()

      device_pin
    end

    test "list_device_pins/0 returns all device_pins" do
      device_pin = device_pin_fixture()
      assert API.list_device_pins() == [device_pin]
    end

    test "get_device_pin!/1 returns the device_pin with given id" do
      device_pin = device_pin_fixture()
      assert API.get_device_pin!(device_pin.id) == device_pin
    end

    test "create_device_pin/1 with valid data creates a device_pin" do
      assert {:ok, %DevicePin{} = device_pin} = API.create_device_pin(@valid_attrs)
      assert device_pin.led_count == 42
      assert device_pin.name == "some name"
      assert device_pin.pin == 42
    end

    test "create_device_pin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_device_pin(@invalid_attrs)
    end

    test "update_device_pin/2 with valid data updates the device_pin" do
      device_pin = device_pin_fixture()
      assert {:ok, device_pin} = API.update_device_pin(device_pin, @update_attrs)
      assert %DevicePin{} = device_pin
      assert device_pin.led_count == 43
      assert device_pin.name == "some updated name"
      assert device_pin.pin == 43
    end

    test "update_device_pin/2 with invalid data returns error changeset" do
      device_pin = device_pin_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_device_pin(device_pin, @invalid_attrs)
      assert device_pin == API.get_device_pin!(device_pin.id)
    end

    test "delete_device_pin/1 deletes the device_pin" do
      device_pin = device_pin_fixture()
      assert {:ok, %DevicePin{}} = API.delete_device_pin(device_pin)
      assert_raise Ecto.NoResultsError, fn -> API.get_device_pin!(device_pin.id) end
    end

    test "change_device_pin/1 returns a device_pin changeset" do
      device_pin = device_pin_fixture()
      assert %Ecto.Changeset{} = API.change_device_pin(device_pin)
    end
  end
end
