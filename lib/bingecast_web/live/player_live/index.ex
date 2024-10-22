defmodule BingecastWeb.PlayerLive.Index do
  use BingecastWeb, :live_view

  alias Bingecast.AudioTest
  alias Bingecast.AudioTest.Player

  @impl true
  def mount(_params, _session, socket) do
    # Assign the audio file path and player collection to the socket
    {:ok,
     socket
     |> stream(:player_collection, AudioTest.list_player())
     |> assign(:audio_file, "/sounds/song.mp3")}  # Use the correct path to your MP3 file
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Player")
    |> assign(:player, AudioTest.get_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Player")
    |> assign(:player, %Player{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Player")
    |> assign(:player, nil)
  end

  @impl true
  def handle_info({BingecastWeb.PlayerLive.FormComponent, {:saved, player}}, socket) do
    {:noreply, stream_insert(socket, :player_collection, player)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    player = AudioTest.get_player!(id)
    {:ok, _} = AudioTest.delete_player(player)

    {:noreply, stream_delete(socket, :player_collection, player)}
  end
end
