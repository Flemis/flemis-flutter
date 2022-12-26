'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "3faa28261f621065de527e2bc1efba2d",
"index.html": "d041aac7a660bef8bd6111d5acf3303e",
"/": "d041aac7a660bef8bd6111d5acf3303e",
"main.dart.js": "240dc2b41304cc9b1735a8bd9fa55eb0",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e7d62139b51a7eb8d5bb322ed5e3d8e5",
"assets/AssetManifest.json": "fb6122e635c72f2c118d34a09919040f",
"assets/NOTICES": "16e04edac4c6cc58091f9eee432107c1",
"assets/FontManifest.json": "23a4a971445c06467a4517e00a41bdcc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dd3c4233029270506ecc994d67785a37",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "613e4cc1af0eb5148b8ce409ad35446d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d1722d5cf2c7855862f68edb85e31f88",
"assets/packages/stories_editor/assets/images/instagram_logo.png": "0a3a43fbb5c19d8a314ae1b226998ac3",
"assets/packages/stories_editor/assets/icons/check.png": "276c385550e5cff378921c80940f2b47",
"assets/packages/stories_editor/assets/icons/align_left.png": "f568808be048f13507c7f447038da90b",
"assets/packages/stories_editor/assets/icons/download.png": "a8198700ad73a0e8dc89ab3aaa19b149",
"assets/packages/stories_editor/assets/icons/return.png": "160981636a15849a1186422fa4e5eb87",
"assets/packages/stories_editor/assets/icons/brush.png": "2dfa8c91efedafbf0df777edccedf23a",
"assets/packages/stories_editor/assets/icons/pen.png": "216679af84ec055ad4fc9cb20c353689",
"assets/packages/stories_editor/assets/icons/circular_gradient.png": "92fafe97810b1b7390bebda0ac349fcb",
"assets/packages/stories_editor/assets/icons/colorpalette.png": "20435e03a09162c24754e02dde0b8eba",
"assets/packages/stories_editor/assets/icons/draw.png": "9a133d3eb7f0fb6c02094feb66907b86",
"assets/packages/stories_editor/assets/icons/arrow.png": "537638741fc80147097552e81e95149a",
"assets/packages/stories_editor/assets/icons/photo_filter.png": "0eb47198093ab4e1938c71461b0f68e0",
"assets/packages/stories_editor/assets/icons/font_backGround.png": "87e27ef20090f0321d6bd8adb2626e86",
"assets/packages/stories_editor/assets/icons/pickColor.png": "64458b46f4ef010479876adb6328e113",
"assets/packages/stories_editor/assets/icons/align_center.png": "45dc3b94013666dc5fd09719e6bda826",
"assets/packages/stories_editor/assets/icons/align_rigth.png": "d8b7c98efd0bca75eb4792ca07d68c60",
"assets/packages/stories_editor/assets/icons/video_trim.png": "045f699a9f5e123f9a1c2a052dce9182",
"assets/packages/stories_editor/assets/icons/trash.png": "16b0c637230accb63d3b8696fd66d95d",
"assets/packages/stories_editor/assets/icons/stickers.png": "e0ebacd952fa7357a20c116ebd596cf7",
"assets/packages/stories_editor/assets/icons/neon.png": "0f7d6338d20822dec650aa925fde192f",
"assets/packages/stories_editor/assets/icons/text.png": "48d1d402d6b7fbaf8f2aa7e3a1f738e0",
"assets/packages/stories_editor/assets/icons/marker.png": "306bf1c099f38d5c3f1af6f783ff4c7e",
"assets/packages/stories_editor/assets/icons/draft.png": "749be7ee9d4445f4a9d8e879fedbfc9f",
"assets/packages/stories_editor/assets/fonts/ReenieBeanie-Regular.ttf": "57cf6c5c7de1387a26e73467a47c1f62",
"assets/packages/stories_editor/assets/fonts/IndieFlower-Regular.ttf": "0841af952c807bdf56455b1addb4c7df",
"assets/packages/stories_editor/assets/fonts/OldStandardTT-Italic.ttf": "cfb6f28612cdb09ea2aa33e0eb30ef92",
"assets/packages/stories_editor/assets/fonts/TitilliumWeb-Regular.ttf": "ed1d014bf2b8b72f27d6af65c69f710a",
"assets/packages/stories_editor/assets/fonts/YatraOne-Regular.ttf": "60b597406a6a70df5bcdabd5bf65d4f5",
"assets/packages/stories_editor/assets/fonts/UnifrakturMaguntia-Regular.ttf": "b55b30c4760000ec7b92a8a4dad81a2c",
"assets/packages/stories_editor/assets/fonts/Vollkorn-Regular.ttf": "f68e078e247114a66838fb7c2ef6b605",
"assets/packages/stories_editor/assets/fonts/Varela-Regular.ttf": "bb4e479a2da1aaca15c79131e369cd03",
"assets/packages/stories_editor/assets/fonts/Sacramento-Regular.ttf": "66b0e223824fd123ab079b60da594ea7",
"assets/packages/stories_editor/assets/fonts/Neonderthaw-Regular.ttf": "4782e3813306cbb976aa3fbc5e00174b",
"assets/packages/stories_editor/assets/fonts/Rakkas-Regular.ttf": "47d92c4db466a2d11d7b7c72bde0c17e",
"assets/packages/stories_editor/assets/fonts/BungeeShade-Regular.ttf": "cbebbd94583826d3866f2bd20ee74bf9",
"assets/packages/stories_editor/assets/fonts/SedgwickAve-Regular.ttf": "6673ac867bffb680d8180f4ba252818d",
"assets/packages/stories_editor/assets/fonts/FrederickatheGreat-Regular.ttf": "9122299e476671f970e1670bd7b900c8",
"assets/packages/stories_editor/assets/fonts/PressStart2P-Regular.ttf": "2c404fd06cd67770807d242b2d2e5a16",
"assets/packages/stories_editor/assets/fonts/ConcertOne-Regular.ttf": "1b40f0186d1a8b1500b4676b2e9a7ba1",
"assets/packages/stories_editor/assets/fonts/Alegreya-VariableFont_wght.ttf": "015630d8318d38534a599076732129a1",
"assets/packages/stories_editor/assets/fonts/B612-Regular.ttf": "87eccad5fa0574a5aa4a88c386d51ed2",
"assets/packages/stories_editor/assets/fonts/DancingScript-VariableFont_wght.ttf": "796bdaef35c72bb17246391811a5d7c1",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttericon/lib/fonts/Octicons.ttf": "7242d2fe9e36eb4193d2bc7e521779bf",
"assets/packages/fluttericon/lib/fonts/Maki.ttf": "9ecdcd7d24a2461a55d532b86b2740bd",
"assets/packages/fluttericon/lib/fonts/Brandico.ttf": "791921e9b25210e2551b6eda3f86c733",
"assets/packages/fluttericon/lib/fonts/Entypo.ttf": "58edfaf27b1032ea4778b69297c02b5a",
"assets/packages/fluttericon/lib/fonts/Fontelico.ttf": "3a1e1cecf0a3eae6be5cba3677379ba2",
"assets/packages/fluttericon/lib/fonts/Iconic.ttf": "34e12214307f5f7cf7bc62086fbf55a3",
"assets/packages/fluttericon/lib/fonts/LineariconsFree.ttf": "276b1d61e45eb9b2dde9482545d9e3ac",
"assets/packages/fluttericon/lib/fonts/RpgAwesome.ttf": "99232001effca5cf2b5aa92cc3f3e892",
"assets/packages/fluttericon/lib/fonts/Typicons.ttf": "3386cae1128e52caf268508d477fb660",
"assets/packages/fluttericon/lib/fonts/FontAwesome.ttf": "799bb4e5c577847874f20bd0e9b38a9d",
"assets/packages/fluttericon/lib/fonts/Zocial.ttf": "c29d6e34d8f703a745c6f18d94ce316d",
"assets/packages/fluttericon/lib/fonts/WebSymbols.ttf": "4fd66aa74cdc6e5eaff0ec916ac269c6",
"assets/packages/fluttericon/lib/fonts/Linecons.ttf": "2d0ac407ed11860bf470cb01745fb144",
"assets/packages/fluttericon/lib/fonts/FontAwesome5.ttf": "221b27a41202ddd33990e299939e4504",
"assets/packages/fluttericon/lib/fonts/Elusive.ttf": "23f24df0388819e94db2b3c19841841c",
"assets/packages/fluttericon/lib/fonts/MfgLabs.ttf": "09daa533ea11600a98e3148b7531afe3",
"assets/packages/fluttericon/lib/fonts/Meteocons.ttf": "8b9c7982496155bb39c67eaf2a243731",
"assets/packages/fluttericon/lib/fonts/ModernPictograms.ttf": "5046c536516be5b91c15eb7795e0352d",
"assets/packages/modal_gif_picker/assets/PoweredBy_200px-Black_HorizLogo.png": "bc83508809a0e22438875348b313e645",
"assets/packages/modal_gif_picker/assets/giphy_logo.png": "45d1b9ca389518ef1b5293505635bb3e",
"assets/packages/modal_gif_picker/assets/PoweredBy_200px-Black_HorizText.png": "439da1ed3ca70fb090eb98698485c21e",
"assets/packages/modal_gif_picker/assets/PoweredBy_200px-White_HorizLogo.png": "fb012bc7c640497104f732a79241743e",
"assets/packages/modal_gif_picker/assets/demo.gif": "0e1c5742401707b7c697b1c61c327b02",
"assets/shaders/ink_sparkle.frag": "ba43ca76b30d6368425c7ff0034c6bfa",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/sunsetphoto.jpeg": "be48c100e9c153e7555e5a8d442c5dfb",
"assets/assets/fernando.jpg": "09ba04603a040406fa9c34170dc76617",
"assets/assets/policies/privacy_policy_pt_br.txt": "c2444d71bb49867783523aad46838fd6",
"assets/assets/policies/privacy_policy_english.txt": "bd61c0763d723d2f6e2d9460af48e8f6",
"assets/assets/avatar.png": "0ce5c75cf4ae4b6163221365a21019c9",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
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
