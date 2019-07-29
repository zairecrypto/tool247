defmodule Tool247Web.UserController do
  use Tool247Web, :controller
  import Ecto
  alias Tool247.{
    Repo, 
    User
  }

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user}) do
    changeset = User.changeset(%User{}, user)
    
    case Repo.insert(changeset) do
      {:ok, _user}         -> 
        add_user(conn, changeset)
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset      
    end
  end

  def show(conn, %{"id" => user_id}) do
    user      = Repo.get(User, user_id)
    changeset = User.changeset(user)
    render conn, "show.html", changeset: changeset, user: user
  end

  def delete(conn, %{"id" => user_id}) do
    Repo.get!(User, user_id) |> Repo.delete!

    conn 
    |> put_flash(:info, "User Deleted Successfully")
    |> redirect(to: user_path(conn, :index))

  end

  def edit(conn, %{"id" => user_id}) do
    user      = Repo.get(User, user_id)
    changeset = User.changeset user
    render conn, "edit.html", changeset: changeset, user: user
  end

  def update(conn, %{"id" => user_id, "user" => user}) do
  
    old_user  = Repo.get(User, user_id)
    changeset = old_user |> User.changeset(user)

    case Repo.update(changeset) do
      {:ok, _user}       -> 
        conn
        |> put_flash(:info, "User Updated")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} -> 
        render conn, "edit.html", changeset: changeset, user: old_user
    end
    
  end

  defp add_user(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User Created")
        |> redirect(to: user_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:info, "Something went wrong! please check email is not yet assigned to a user!")
        |> redirect(to: user_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil   -> Repo.insert(changeset)
      user  -> {:ok, user}        
    end
  end
  
  

end
