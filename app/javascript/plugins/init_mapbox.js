import mapboxgl from "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";
mapboxgl.workerClass = require("worker-loader!mapbox-gl/dist/mapbox-gl-csp-worker").default;

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([markers.long, markers.lat]);
  map.fitBounds(bounds, { padding: 70, maxZoom: 16, duration: 1000 });
};

const initMapbox = () => {
  const mapElement = document.getElementById("map");

  if (mapElement) {
    // only build a map if there's a div#map to inject into

    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v11",
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    const element = document.createElement("div");
    element.className = "marker";
    element.style.backgroundImage = `url('${markers.image_url}')`;
    element.style.backgroundSize = "contain";
    element.style.width = "50px";
    element.style.height = "50px";

    new mapboxgl.Marker(element)
      .setLngLat([markers.long, markers.lat])
      .addTo(map);

    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
