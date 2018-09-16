defmodule LEDxServer.Repo.Migrations.CreateDevicePins do
  use Ecto.Migration

  def change do
    create table(:device_pins, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:device_id, references(:devices, on_delete: :delete_all, type: :binary_id), null: false)
      add(:name, :string)
      add(:pin, :integer)
      add(:led_count, :integer)

      timestamps()
    end

    create(unique_index(:device_pins, [:name, :device_id]))
    create(unique_index(:device_pins, [:pin, :device_id]))
    create(index(:device_pins, [:device_id]))
  end
end
