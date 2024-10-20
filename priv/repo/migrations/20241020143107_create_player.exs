defmodule Bingecast.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:player) do

      timestamps(type: :utc_datetime)
    end
  end
end
