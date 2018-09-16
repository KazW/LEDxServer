defmodule LEDxServer.Schemas.Device do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "devices" do
    has_many(:pins, LEDxServer.Schemas.DevicePin)

    field(:name, :string)
    field(:hardware_id, :integer)
    field(:powered_on, :boolean, default: false)

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :hardware_id, :powered_on])
    |> validate_required([:name, :hardware_id, :powered_on])
    |> unique_constraint(:name)
    |> unique_constraint(:hardware_id)
  end
end
