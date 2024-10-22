defmodule Bingecast.AudioTestTest do
  use Bingecast.DataCase

  alias Bingecast.AudioTest

  describe "player" do
    alias Bingecast.AudioTest.Player

    import Bingecast.AudioTestFixtures

    @invalid_attrs %{}

    test "list_player/0 returns all player" do
      player = player_fixture()
      assert AudioTest.list_player() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert AudioTest.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{}

      assert {:ok, %Player{} = player} = AudioTest.create_player(valid_attrs)
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AudioTest.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{}

      assert {:ok, %Player{} = player} = AudioTest.update_player(player, update_attrs)
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = AudioTest.update_player(player, @invalid_attrs)
      assert player == AudioTest.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = AudioTest.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> AudioTest.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = AudioTest.change_player(player)
    end
  end
end
