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

  def create(conn, %{"project" => project}) do
    
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


  def update(conn, %{"id" => project_id, "project" => project}) do
  
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
