// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
 import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

import "../vendor/pannellum.js"

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()

window.liveSocket = liveSocket

document.addEventListener("DOMContentLoaded", () => {
  //const startRecordingButton = document.getElementById("startRecording");
  //const stopRecordingButton = document.getElementById("stopRecording");
  const playProcessedAudioButton = document.getElementById("play");

  //startRecordingButton.addEventListener("click", startRecording);
  //stopRecordingButton.addEventListener("click", stopRecording);
  playProcessedAudioButton.addEventListener("click", playAudio);

});

async function startRecording() {
  const startRecordingButton = document.getElementById("startRecording");
  startRecordingButton.disabled = true;

  const stream = await navigator.mediaDevices.getUserMedia({ audio: true });

  mediaRecorder = new MediaRecorder(stream);
  mediaRecorder.addEventListener("dataavailable", (event) => {
      recordedChunks.push(event.data);
  });

  mediaRecorder.start();

  stopRecordingButton.disabled = false;
}

async function stopRecording() {
    stopRecordingButton.disabled = true;

    mediaRecorder.stop();

    const recordedBlob = new Blob(recordedChunks, { type: "audio/webm" });
    const recordedBuffer = await blobToArrayBuffer(recordedBlob);

    const originalAudioBuffer = await audioContext.decodeAudioData(recordedBuffer);
    processedAudioBuffer = await applyRoomAcoustics(originalAudioBuffer);

    playProcessedAudioButton.disabled = false;
}

function playAudio() {
  const audioCtx = new AudioContext();
  const convolver = audioCtx.createConvolver();
  const gainNode = audioCtx.createGain();
  let source;

  // Load impulse response
  const ajaxRequest = new XMLHttpRequest();
  ajaxRequest.open("GET", "/impulse_responses/1/play", true);
  ajaxRequest.responseType = "arraybuffer";

  ajaxRequest.onload = () => {
    const audioData = ajaxRequest.response;
    audioCtx.decodeAudioData(
      audioData,
      (buffer) => {
        convolver.buffer = buffer;

        // Get microphone input
        const constraints = { audio: true };
        navigator.mediaDevices
          .getUserMedia(constraints)
          .then(function (stream) {
            source = audioCtx.createMediaStreamSource(stream);
            source.connect(convolver);
            convolver.connect(gainNode);
            gainNode.connect(audioCtx.destination);
          })
          .catch(function (err) {
            console.log("The following gUM error occured: " + err);
          });
      },
      (e) => console.error(`Error with decoding audio data: ${e.err}`)
    );
  };

  ajaxRequest.send();
}

function blobToArrayBuffer(blob) {
    return new Promise((resolve) => {
        const reader = new FileReader();
        reader.onloadend = () => resolve(reader.result);
        reader.readAsArrayBuffer(blob);
    });
}

async function applyRoomAcoustics(audioBuffer) {
  const convolutionNode = audioContext.createConvolver();
  convolutionNode.buffer = impulseResponseBuffer;

  const bufferSource = audioContext.createBufferSource();
  bufferSource.buffer = audioBuffer;
  bufferSource.connect(convolutionNode);
  convolutionNode.connect(audioContext.destination);

  bufferSource.start();

  return audioBuffer;
}

/*
import { OrbitControls } from "https://cdn.jsdelivr.net/npm/three@0.121.1/examples/jsm/controls/OrbitControls.js";

document.addEventListener("DOMContentLoaded", () => {
  const instrumentDropdown = document.getElementById("instrument-dropdown");
  const container = document.getElementById('viewer-container');
// Define the mapping between the instrument values and their corresponding 3D model file paths
const instrumentModels = {
  Rock: "images/rock.glb",
  Rock2: "images/rock2.glb",
  Amphi: "images/amphi.glb",
};

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
  const renderer = new THREE.WebGLRenderer({ antialias: true });

  const raycaster = new THREE.Raycaster();
  const mouse = new THREE.Vector2();

  renderer.setSize(400, 400);
  container.appendChild(renderer.domElement);

  const loader = new THREE.GLTFLoader();
  loader.load(
    'images/sound.glb',
    (gltf) => {
      scene.add(gltf.scene);
      camera.position.set(0, 0, 5); // Adjust the camera position as needed
      camera.fov = 10; // Change the fov value to zoom in or out
      camera.updateProjectionMatrix(); // Apply the changes to the camera
      const ambientLight = new THREE.AmbientLight(0xffffff, 1); // Create an ambient light with white color and intensity of 0.5
      scene.add(ambientLight); // Add the ambient light to the scene

      const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
      directionalLight.position.set(-1, 2, 4);
      scene.add(directionalLight);

      function onClick(event) {
        // calculate mouse position in normalized device coordinates
        // (-1 to +1) for both components
        mouse.x = (event.clientX / renderer.domElement.clientWidth) * 2 - 1;
        mouse.y = -(event.clientY / renderer.domElement.clientHeight) * 2 + 1;

        // update the picking ray with the camera and mouse position
        raycaster.setFromCamera(mouse, camera);

        // intersectObjects returns an array of intersections
        const intersects = raycaster.intersectObjects(scene.children, true);

        console.log(intersects.map( o => o.object.name));
        const soundIntersects = intersects.filter(intersect => intersect.object.name === "Sound");

        if (soundIntersects.length > 0) {
          console.log("Clicked on SOUND");
        }
      }

      renderer.domElement.addEventListener("click", onClick);
    },
    undefined,
    (error) => console.error(error)
  );

  const controls = new OrbitControls(camera, renderer.domElement);

  const animate = () => {
    requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
  };

  animate();

  // Update the model-viewer when the instrument-dropdown selection changes
  //instrumentDropdown.addEventListener("change", updateModelViewer);
});
*/

document.addEventListener("DOMContentLoaded", () => {
  const placeDropdown = document.getElementById("place-dropdown");
  const panorama = document.getElementById("panorama");
  const firstImageId = panorama.dataset.firstImageId;

  // Initialize the Pannellum viewer with the first image's ID as the default panorama
  const viewer = pannellum.viewer("panorama", {
    default: {
      firstScene: "grand",
      author: "Joy Pisanu",
      sceneFadeDuration: 1000,
      autoLoad: true,
      maxPitch: 0,
      minPitch: 0,
      maxYaw: 90,
      minYaw: -90
    },
    scenes: {
      grand: {
        title: "The Grand",
        panorama: `/images/${firstImageId}/jpeg`
      }
    }
  });

  // Function to update the panorama based on the selected place ID
  function updatePanorama(imageId) {
    console.log(imageId)
    // Update the panorama URL and reload the viewer
    viewer.updateConfig({
      scenes: {
        grand: {
          title: "The Grand",
          panorama: `/images/${imageId}/jpeg`
        }
      }
    });
  }

  // Listen for the change event on the place-dropdown select element
  placeDropdown.addEventListener("change", function () {
    const selectedPlaceId = placeDropdown.value;
    updatePanorama(selectedPlaceId);
  });
});
