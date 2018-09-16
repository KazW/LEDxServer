defmodule LEDxServer.Schemas.DevicePin do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "device_pins" do
    belongs_to(:device, LEDxServer.Schemas.Device)

    field(:name, :string)
    field(:pin, :integer)
    field(:led_count, :integer)

    timestamps()
  end

  @doc false
  def changeset(device_pin, attrs) do
    device_pin
    |> cast(attrs, [:device_id, :name, :pin, :led_count])
    |> validate_required([:device_id, :name, :pin, :led_count])
    |> unique_constraint(:name, name: :device_pins_name_device_id_index)
    |> unique_constraint(:pin, name: :device_pins_pin_device_id_index)
  end
end
