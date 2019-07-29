defmodule Tool247.Repo.Migrations.AddOtherFieldToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :service, :text
      add :summary, :text
      add :intended_customers, :string
      add :hours_of_availability, :string
      add :related_services, :string
      add :how_to_request, :string
      add :business_Owner, :string
      add :sla, :text
      add :important_links, :text

    end
  end
end



