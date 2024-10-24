defmodule BingecastWeb.ApiSessionController do
  use BingecastWeb, :controller

  alias Bingecast.Accounts
  alias BingecastWeb.UserAuth

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      token_data = %{user_id: user.id}
      token = Phoenix.Token.sign(BingecastWeb.Endpoint, "user session", token_data)
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(201, Jason.encode!(%{token: token}))
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(403, Jason.encode!(%{msg: "Bad auth request"}))
    end
  end
end
