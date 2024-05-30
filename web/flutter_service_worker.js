'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "f083f1277425627f6e7208080ad7fc88",
"favicon.png1": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-maskable-192.png": "c1ab4606b65e7a8d3bc6a703ddc15cb1",
"icons/Icon-maskable-512.png": "56a5a65b11dc4410054b339a42c83133",
"icons/Icon-192.png": "638fa4e22922c66d6bc5346a52a18e1c",
"icons/Icon-512.png": "c37659a78a83b5e50de2afcf020da360",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "6c55d8a1f0723db6f75a78015f2fcb38",
"canvaskit/skwasm.js": "5b13215adfc99b441723b8d1c9987b43",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.wasm": "cf17efa366ffd7a272339eac21a7d912",
"canvaskit/chromium/canvaskit.wasm": "d102b43cdb4abb9764fedd92e62b270d",
"canvaskit/chromium/canvaskit.js": "9c4f8f68506cf4d2dc9b05219cd69920",
"canvaskit/skwasm.wasm": "e52fdf38db45a29d98069d87dbff17fe",
"canvaskit/canvaskit.js": "42cca10620a5e19f50b4d5cb990b74bf",
"version.json": "c3e9722d704d723a62db9b6ec4f9babd",
"index.html": "9c8a6345b7c4241920f48e2ad99ee021",
"/": "9c8a6345b7c4241920f48e2ad99ee021",
"assets/fonts/MaterialIcons-Regular.otf": "145550b988023701e7fb1c2d1be6b29a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/AssetManifest.bin.json": "228045feb83ffc06aabd5ee392ee6026",
"assets/AssetManifest.bin": "2ffa2534f229859c12484b7e3561c98a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.json": "1d3da83256acfcdf653bc94849f5084f",
"assets/assets/xlsm.png": "65b2355c74df0d7a60d6b56d6e438807",
"assets/assets/docx.png": "f4688e9026f20deaddcdbd11bcb78d08",
"assets/assets/odt.png": "0ed2aab03c273ac8b76335321f88d4a5",
"assets/assets/doc.png": "3da177e02f131656140bfcea09ae65ba",
"assets/assets/icon/qweb.png": "2ed14cfe4df1e74b7346293000453b3d",
"assets/assets/icon/qwebservice.png": "68ad525d79f1278c39f45e405dfa1420",
"assets/assets/icon/banner.png": "5c2fe8636334d58c222ffa8417217c3e",
"assets/assets/ods.png": "4cf79e14bdd377a5e97841ba1f2a4617",
"assets/assets/mpp.png": "b846776ad848820c7e33bce0909d522a",
"assets/assets/no-document.png": "faf5bbea9ec27894eb47d7d5f20904db",
"assets/assets/jpeg.png": "744443ad60b562bc76b4dd7b58242f29",
"assets/assets/pptx.png": "aee2c82e532a485a378d6a50da60a12f",
"assets/assets/xls.png": "ef736590774b232689a8be306d373b77",
"assets/assets/logo.png": "3613278fcfd3b481992806f9a1069e5f",
"assets/assets/xlsx.png": "fb63c20ba27d2e12ffb324019f6ce1fc",
"assets/assets/jar-loading.gif": "a0a7f99bbe4eb3f98bc9c957d8dd1756",
"assets/assets/no-image.png": "1bdef0b5837fe56734fd7d7d93a83ee5",
"assets/assets/png.png": "8b9249e611075a76ea5fb701b569fcd8",
"assets/assets/pdf.png": "909b7e558d817070b62eec7ccb6542e9",
"assets/assets/txt.png": "daeeee348d6b992996bb403a363e92d3",
"assets/assets/jpg.png": "71dc087d6146f8fcc5dc1daeac6946ff",
"assets/assets/vsdx.png": "83c5b7056540de765962c5b9b445a92d",
"assets/NOTICES": "3e2c7dfe5a715fdb34332b0f9a73a80e",
"manifest.json": "b76050b64e9a19307d27b4194f2b1609"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
