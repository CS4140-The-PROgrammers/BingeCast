defmodule BingecastWeb.PlayerLiveTest do
  use BingecastWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bingecast.AudioTestFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_player(_) do
    player = player_fixture()
    %{player: player}
  end

  describe "Index" do
    setup [:create_player]

    test "lists all player", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/player")

      assert html =~ "Listing Player"
    end

    test "saves new player", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/player")

      assert index_live |> element("a", "New Player") |> render_click() =~
               "New Player"

      assert_patch(index_live, ~p"/player/new")

      assert index_live
             |> form("#player-form", player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#player-form", player: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/player")

      html = render(index_live)
      assert html =~ "Player created successfully"
    end

    test "updates player in listing", %{conn: conn, player: player} do
      {:ok, index_live, _html} = live(conn, ~p"/player")

      assert index_live |> element("#player-#{player.id} a", "Edit") |> render_click() =~
               "Edit Player"

      assert_patch(index_live, ~p"/player/#{player}/edit")

      assert index_live
             |> form("#player-form", player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#player-form", player: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/player")

      html = render(index_live)
      assert html =~ "Player updated successfully"
    end

    test "deletes player in listing", %{conn: conn, player: player} do
      {:ok, index_live, _html} = live(conn, ~p"/player")

      assert index_live |> element("#player-#{player.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#player-#{player.id}")
    end
  end

  describe "Show" do
    setup [:create_player]

    test "displays player", %{conn: conn, player: player} do
      {:ok, _show_live, html} = live(conn, ~p"/player/#{player}")

      assert html =~ "Show Player"
    end

    test "updates player within modal", %{conn: conn, player: player} do
      {:ok, show_live, _html} = live(conn, ~p"/player/#{player}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Player"

      assert_patch(show_live, ~p"/player/#{player}/show/edit")

      assert show_live
             |> form("#player-form", player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#player-form", player: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/player/#{player}")

      html = render(show_live)
      assert html =~ "Player updated successfully"
    end
  end
end
