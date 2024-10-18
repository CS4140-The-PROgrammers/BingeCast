defmodule Bingecast.Repo do
  use Ecto.Repo,
    otp_app: :bingecast,
    adapter: Ecto.Adapters.SQLite3
end
