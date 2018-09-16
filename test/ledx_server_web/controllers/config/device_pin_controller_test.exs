defmodule LEDxServerWeb.Config.DevicePinControllerTest do
  use LEDxServerWeb.ConnCase

  alias LEDxServer.Config

  @create_attrs %{led_count: 42, name: "some name", pin: 42}
  @update_attrs %{led_count: 43, name: "some updated name", pin: 43}
  @invalid_attrs %{led_count: nil, name: nil, pin: nil}

  def fixture(:device_pin) do
    {:ok, device_pin} = Config.create_device_pin(@create_attrs)
    device_pin
  end

  describe "index" do
    test "lists all device_pins", %{conn: conn} do
      conn = get(conn, config_device_pin_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Device pins"
    end
  end

  describe "new device_pin" do
    test "renders form", %{conn: conn} do
      conn = get(conn, config_device_pin_path(conn, :new))
      assert html_response(conn, 200) =~ "New Device pin"
    end
  end

  describe "create device_pin" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, config_device_pin_path(conn, :create), device_pin: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == config_device_pin_path(conn, :show, id)

      conn = get(conn, config_device_pin_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Device pin"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, config_device_pin_path(conn, :create), device_pin: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Device pin"
    end
  end

  describe "edit device_pin" do
    setup [:create_device_pin]

    test "renders form for editing chosen device_pin", %{conn: conn, device_pin: device_pin} do
      conn = get(conn, config_device_pin_path(conn, :edit, device_pin))
      assert html_response(conn, 200) =~ "Edit Device pin"
    end
  end

  describe "update device_pin" do
    setup [:create_device_pin]

    test "redirects when data is valid", %{conn: conn, device_pin: device_pin} do
      conn =
        put(conn, config_device_pin_path(conn, :update, device_pin), device_pin: @update_attrs)

      assert redirected_to(conn) == config_device_pin_path(conn, :show, device_pin)

      conn = get(conn, config_device_pin_path(conn, :show, device_pin))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, device_pin: device_pin} do
      conn =
        put(conn, config_device_pin_path(conn, :update, device_pin), device_pin: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Device pin"
    end
  end

  describe "delete device_pin" do
    setup [:create_device_pin]

    test "deletes chosen device_pin", %{conn: conn, device_pin: device_pin} do
      conn = delete(conn, config_device_pin_path(conn, :delete, device_pin))
      assert redirected_to(conn) == config_device_pin_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, config_device_pin_path(conn, :show, device_pin))
      end)
    end
  end

  defp create_device_pin(_) do
    device_pin = fixture(:device_pin)
    {:ok, device_pin: device_pin}
  end
end
