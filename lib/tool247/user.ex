defmodule Tool247.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field :email, :string, null: false
        field :name, :string, default: "guest"
        field :password, :string, default: "247", null: false
        field :is_admin, :boolean, default: false, null: false

        has_many :topics, Tool247.Project
        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:email, :name, :password, :is_admin])
        |> validate_required([:email])
    end
end