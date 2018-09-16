defmodule LEDxServer.API.DevicePins do
  @moduledoc """
  The API context for Device Pins.
  """

  import Ecto.Query, warn: false
  alias LEDxServer.Repo

  alias LEDxServer.Schemas.DevicePin

  @doc """
  Returns the list of device_pins.

  ## Examples

      iex> list_device_pins()
      [%DevicePin{}, ...]

  """
  def list_device_pins do
    Repo.all(DevicePin)
  end

  @doc """
  Gets a single device_pin.

  Raises `Ecto.NoResultsError` if the Device pin does not exist.

  ## Examples

      iex> get_device_pin!(123)
      %DevicePin{}

      iex> get_device_pin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device_pin!(id), do: Repo.get!(DevicePin, id)

  @doc """
  Creates a device_pin.

  ## Examples

      iex> create_device_pin(%{field: value})
      {:ok, %DevicePin{}}

      iex> create_device_pin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device_pin(attrs \\ %{}) do
    %DevicePin{}
    |> DevicePin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device_pin.

  ## Examples

      iex> update_device_pin(device_pin, %{field: new_value})
      {:ok, %DevicePin{}}

      iex> update_device_pin(device_pin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device_pin(%DevicePin{} = device_pin, attrs) do
    device_pin
    |> DevicePin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DevicePin.

  ## Examples

      iex> delete_device_pin(device_pin)
      {:ok, %DevicePin{}}

      iex> delete_device_pin(device_pin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device_pin(%DevicePin{} = device_pin) do
    Repo.delete(device_pin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device_pin changes.

  ## Examples

      iex> change_device_pin(device_pin)
      %Ecto.Changeset{source: %DevicePin{}}

  """
  def change_device_pin(%DevicePin{} = device_pin) do
    DevicePin.changeset(device_pin, %{})
  end
end
