defmodule Bingecast.AudioTestFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bingecast.AudioTest` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{

      })
      |> Bingecast.AudioTest.create_player()

    player
  end
end
