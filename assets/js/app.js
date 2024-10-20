// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
// The simplest option is to put them in assets/vendor and import them using relative paths:
//     import "../vendor/some-package.js"
// Alternatively, you can `npm install some-package --prefix assets` and import them using a path starting with the package name:
//     import "some-package"

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

// Import Howler.js for audio playback
import { Howl, Howler } from "howler";

// CSRF Token Setup
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken }
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", _info => topbar.show(300));
window.addEventListener("phx:page-loading-stop", _info => topbar.hide());

// Connect if there are any LiveViews on the page
liveSocket.connect();

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// ---------------------
// Howler.js Integration
// ---------------------

// Initialize Howler.js with the audio file
const sound = new Howl({
  src: ["/sounds/song.mp3"],  // Ensure the MP3 is placed in `assets/static/sounds`
  html5: true,  // Enables streaming for large files
  volume: 1.0   // Volume: 0.0 (mute) to 1.0 (max)
});

document.addEventListener("DOMContentLoaded", () => {
  const playButton = document.getElementById("play-button");
  const pauseButton = document.getElementById("pause-button");
  const seekBar = document.getElementById("seekbar");

  // Play button event
  if (playButton) {
    playButton.addEventListener("click", () => sound.play());
  }

  // Pause button event
  if (pauseButton) {
    pauseButton.addEventListener("click", () => sound.pause());
  }

  // Update seek bar while the audio is playing
  sound.on("play", () => {
    requestAnimationFrame(updateSeekBar);
  });

  function updateSeekBar() {
    const progress = (sound.seek() / sound.duration()) * 100;
    seekBar.value = progress;
    if (sound.playing()) {
      requestAnimationFrame(updateSeekBar);
    }
  }

  // Seek to a new position when the user interacts with the seek bar
  seekBar.addEventListener("input", (e) => {
    const seekTo = (e.target.value / 100) * sound.duration();
    sound.seek(seekTo);
  });
});
