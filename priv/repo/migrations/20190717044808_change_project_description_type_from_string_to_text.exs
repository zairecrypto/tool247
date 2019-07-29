defmodule Tool247.Repo.Migrations.ChangeProjectDescriptionTypeFromStringToText do
  use Ecto.Migration

  def change do
    alter table :projects do
      modify :description, :text      
    end
  end
end
