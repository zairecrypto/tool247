defmodule Tool247.Repo.Migrations.AddUserDb do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, default: "guest"
      add :password, :string, default: "247", null: false
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end
  end
end
