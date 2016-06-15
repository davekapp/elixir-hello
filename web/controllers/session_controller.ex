defmodule Hello.SessionController do
  use Hello.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Hello.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "YAY!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "UR A LIAR NOT REAL ACCOUNTN HAA")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Hello.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
