defmodule Tool247.Repo.Migrations.AddProjectDb do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end
  end
end
