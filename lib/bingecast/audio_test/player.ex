defmodule Bingecast.AudioTest.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [])
    |> validate_required([])
  end
end
