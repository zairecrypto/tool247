defmodule Tool247Web.ProjectController do
  use Tool247Web, :controller
  import Ecto
  alias Tool247.{
    Repo,
    Project,
    User
  }

  def index(conn, _params) do
    projects = Repo.all(Project)
    render conn, "index.html", projects: projects
  end

  def new(conn, _params) do
    changeset = Project.changeset(%Project{}, %{})
    users = Repo.all(User)
    render conn, "new.html", changeset: changeset, users: users
  end

  def create(conn, %{
    "editor1" => description,
    "editor2" => sla,
    "editor3" => related_services,
    "editor4" => important_links,
    "project" => %{
        "business_Owner" => business_Owner,
        "hours_of_availability" => hours_of_availability,
        "how_to_request" => how_to_request,
        "intended_customers" => intended_customers,
        "name" => name,
        "service" => service
      }
    }) do

    project = %{
      "name" => name,
      "description" => description,
      "service" => service,
      "intended_customers" => intended_customers,
      "hours_of_availability" => hours_of_availability,
      "related_services" => related_services,
      "how_to_request" => how_to_request,
      "business_Owner" => business_Owner,
      "sla" => sla,
      "important_links" => important_links
    }

    changeset = %Project{} |> Project.changeset(project)

    %{"name" => name} = project
    IO.inspect project

    if name == "" do
      conn
        |> put_flash(:error, "Something went wrong! Please make sure there is a valid project name")
        |> redirect(to: project_path(conn, :new, project))
    else
      case Repo.get_by(Project, name: changeset.changes.name) do
        nil         ->
          add_project conn, changeset
        project ->
          conn
          |> put_flash(:error, "Something went wrong! Please make sure there is a valid project name")
          |> redirect(to: project_path(conn, :index))
      end
    end
  end


  def delete(conn, %{"id" => project_id}) do

    IO.puts "HERE"
    Repo.get!(Project, project_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Project Deleted Successfully")
    |> redirect(to: project_path(conn, :index))

  end

  def edit(conn, %{"id" => project_id}) do
    project   = Repo.get(Project, project_id)
    changeset = Project.changeset project
    render conn, "edit.html", changeset: changeset, project: project
  end

  def show(conn, %{"id" => project_id}) do
    project   = Repo.get(Project, project_id)
    changeset = Project.changeset project
    render conn, "show.html", changeset: changeset, project: project

  end


  def update(conn, %{
      "id" => project_id,
      "editor1" => description,
      "editor2" => sla,
      "editor3" => related_services,
      "editor4" => important_links,
      "project" => %{
        "business_Owner" => business_Owner,
        "hours_of_availability" => hours_of_availability,
        "how_to_request" => how_to_request,
        "intended_customers" => intended_customers,
        "name" => name,
        "service" => service
      }
    }) do

      project = %{
        "name" => name,
        "description" => description,
        "service" => service,
        "intended_customers" => intended_customers,
        "hours_of_availability" => hours_of_availability,
        "related_services" => related_services,
        "how_to_request" => how_to_request,
        "business_Owner" => business_Owner,
        "sla" => sla,
        "important_links" => important_links
      }

      old_project  = Repo.get(Project, project_id)
      changeset = old_project |> Project.changeset(project)

      case Repo.update(changeset) do
        {:ok, _project}       ->
          conn
          |> put_flash(:info, "Project Updated")
          |> redirect(to: project_path(conn, :index))
        {:error, changeset} ->
          render conn, "edit.html", changeset: changeset, project: old_project
      end

  end

    defp add_project(conn, changeset) do

        case Repo.insert(changeset) do
          {:ok, _struct} ->
            conn
            |> put_flash(:info, "Project Created")
            |> redirect(to: project_path(conn, :index))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong! Please use a different name or a different description")
            |> redirect(to: project_path(conn, :index))
        end
  end


end
