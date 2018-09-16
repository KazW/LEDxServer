defmodule LEDxServer.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:hardware_id, :integer)
      add(:powered_on, :boolean, default: false, null: false)

      timestamps()
    end

    create(unique_index(:devices, [:name]))
    create(unique_index(:devices, [:hardware_id]))
  end
end
