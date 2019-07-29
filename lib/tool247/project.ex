defmodule Tool247.Project do
    use Ecto.Schema
    import Ecto.Changeset

    schema "projects" do
      field :name, :string, null: false
      field :description, :string
      field :service, :string
      field :intended_customers, :string
      field :summary, :string
      field :hours_of_availability, :string
      field :related_services, :string
      field :how_to_request, :string
      field :business_Owner, :string
      field :sla, :string
      field :important_links, :string

      belongs_to :user, Tool247.User
      has_many :processes, Tool247.Process
    
      timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:name, :description, :service, :summary, :intended_customers, :hours_of_availability, :related_services, :how_to_request, :business_Owner, :sla, :important_links])
        |> validate_required([:name])
    end
end