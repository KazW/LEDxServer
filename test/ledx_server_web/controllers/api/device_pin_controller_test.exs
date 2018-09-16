defmodule LEDxServerWeb.API.DevicePinControllerTest do
  use LEDxServerWeb.ConnCase

  alias LEDxServer.API
  alias LEDxServer.API.DevicePin

  @create_attrs %{led_count: 42, name: "some name", pin: 42}
  @update_attrs %{led_count: 43, name: "some updated name", pin: 43}
  @invalid_attrs %{led_count: nil, name: nil, pin: nil}

  def fixture(:device_pin) do
    {:ok, device_pin} = API.create_device_pin(@create_attrs)
    device_pin
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all device_pins", %{conn: conn} do
      conn = get(conn, api_device_pin_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create device_pin" do
    test "renders device_pin when data is valid", %{conn: conn} do
      conn = post(conn, api_device_pin_path(conn, :create), device_pin: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, api_device_pin_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "led_count" => 42,
               "name" => "some name",
               "pin" => 42
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, api_device_pin_path(conn, :create), device_pin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update device_pin" do
    setup [:create_device_pin]

    test "renders device_pin when data is valid", %{
      conn: conn,
      device_pin: %DevicePin{id: id} = device_pin
    } do
      conn = put(conn, api_device_pin_path(conn, :update, device_pin), device_pin: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, api_device_pin_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "led_count" => 43,
               "name" => "some updated name",
               "pin" => 43
             }
    end

    test "renders errors when data is invalid", %{conn: conn, device_pin: device_pin} do
      conn = put(conn, api_device_pin_path(conn, :update, device_pin), device_pin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete device_pin" do
    setup [:create_device_pin]

    test "deletes chosen device_pin", %{conn: conn, device_pin: device_pin} do
      conn = delete(conn, api_device_pin_path(conn, :delete, device_pin))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, api_device_pin_path(conn, :show, device_pin))
      end)
    end
  end

  defp create_device_pin(_) do
    device_pin = fixture(:device_pin)
    {:ok, device_pin: device_pin}
  end
end
