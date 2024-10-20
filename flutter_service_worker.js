'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "37f87d04dd95220670f889eef31d0408",
"index.html": "56f36c2ead1d9fdbb955d329c6bc0348",
"/": "56f36c2ead1d9fdbb955d329c6bc0348",
"version.json": "7af4e8cfb7cd22b96b1a6a0dac3902ad",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/fonts/MaterialIcons-Regular.otf": "eb35efe836e56d5de836b7c5f26ae79c",
"assets/AssetManifest.json": "40188115d6f1cde1b1b1b56478cfb1ae",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ab7e8e99c1128a0f763dfdf928f2d546",
"assets/AssetManifest.bin.json": "db370531826b69f29d0e3466935eb830",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/matches.json": "5b7f32bfaad25fe6a4a7a3c360334c76",
"assets/NOTICES": "6e08351af19904c8c98dab6da7378170",
"main.dart.js": "b0e17b59665f5fb2250b666206cb49e6",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
".git/HEAD": "978cf7ce582a3595b9d4daf7cc63115a",
".git/index": "45a2a2548400318f7c6209dfacc8bb36",
".git/COMMIT_EDITMSG": "655d242e09a0059e6c1fb1b459626ad7",
".git/config": "6f1a0b00ee4d84b7c8c73071bcfdb47d",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/refs/remotes/origin/ghpages": "efbbebf2600f4888dbab6e8f670ef173",
".git/refs/heads/ghpages": "efbbebf2600f4888dbab6e8f670ef173",
".git/logs/HEAD": "6a955f996b765117a551ef2a6b443b4a",
".git/logs/refs/remotes/origin/ghpages": "ef4b509f2e6fc26a38d530260fabf2c5",
".git/logs/refs/heads/ghpages": "4fabe017d65befc65b2bd71509751610",
".git/objects/02/1101eafa38b6c9faae82024ba8d3c39a2159e3": "37351d092bbc98954125a80dfb23f13f",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/e7/4940e24389c921433e28e5927562e67460bd5a": "caeda771011fc98b1bc4f220a169aedf",
".git/objects/9d/d73ff57393ed6cabd7c29be001499bf31e54aa": "9920c5d5793c777136ae6cf9488618ba",
".git/objects/e0/a5bbb8e128aaf660bd2b2d081ffc3e50fc7069": "b853eb345c0b7a41d23b9e01be86400c",
".git/objects/9f/672e08d0cf8f6a04b629e05bbeafba1e86ffa5": "82217463b1bc0a28b9b308f47ed4451e",
".git/objects/9f/37d195db00d91d94890a7936b19ffbeea9af73": "31c5ec989879c846c8b098639327b73c",
".git/objects/31/589ace78e9d2d40f621406fbc907a95050cc37": "6a3b3fa4741fa9770120d50e7882a86a",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/0a/df9f29c514dc20fb60745dc7e0c977bf846d3d": "9d130725bea3e2026c4f7f23eba3012b",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/da/aa73e5cb9abd1a68da77e249f1ac76ae9aab11": "b9a28ac3f7c18dcd855d502e75dd7cd8",
".git/objects/cd/74af4563aadcfa142916af69e7a5d53b338c03": "0ad17f58feb9deb8bdd11ab3699cc5fd",
".git/objects/6b/e909fbf40b23748412f0ea89bf0fae827ed976": "5f118419157d9534688915220cc803f7",
".git/objects/f5/010cda95492006dae3638dfb01a8d0822a1e6a": "04eb9fcdf209b67f396e5ab84cb956e2",
".git/objects/f0/3f556a6bdacc6d0a9293bb2a9b6797388ab10a": "297c30f3fdd0fa2232b6b96eaff20ece",
".git/objects/3c/f5ea9ba7c5459564fae323dfa6c3e854c97322": "72846c927781d41c763c785f2a840a2e",
".git/objects/4e/d924352ede6ce47285a268d8f653e30c32068b": "07835e99f8492b28e92aa08021bf998f",
".git/objects/5d/15fadf1864d70c7184fca7d3efde79cdf68af5": "79a44d8578cc18e3add64aa6a97f0da0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/9b4d48597f511aecef71401dbbdd09c5f95b97": "992c07fd90d35bea12d03bce35b374bf",
".git/objects/d2/8cea714cba96347ad91e6a98a8c0d50e5d093f": "38092e42b7b176fc08a9d7735c1d9dce",
".git/objects/b9/c36e492c6dab39bcd83f776c8eed59a8eeb25e": "370b79e136d364d47d877306c651a26e",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/45/83bb465dc439c8f1594949f24c5858c0277242": "f65bc0e587e45969d92a83165a84c5ff",
".git/objects/63/7948354f22e61cd90a9a969ee1847f3ffa7c43": "e24edff839504ed83f5a5c824715cec7",
".git/objects/16/5da67191b73406e15fc3e6cf7cda3c195dc735": "86cfac30d97fb45bba2f4417782645d6",
".git/objects/42/f394e1aafba8a875ecc981adef59249c3a671b": "3a76331b531c4ffcf5d6d04a3a1c5ac5",
".git/objects/a5/c563ddbb33d7d75e133e38b40dcf6705169150": "e91acc093b9a878249e0b20b9efce259",
".git/objects/a5/3efdf92300d180241adcd14d81d15a734c4e08": "cdce04155deb291d95d5b2a8a45a186e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/32/aa3cae58a7432051fc105cc91fca4d95d1d011": "4f8558ca16d04c4f28116d3292ae263d",
".git/objects/2a/42705bd5b1dbd22d78ff8e14919561f511cf6b": "2efd2febeecc92549215a5ec1e14f155",
".git/objects/7e/75e882470d338dd3d1f62460754c08af092bdc": "5da8ac49c4aacc9d9dd546c481b57724",
".git/objects/54/e7822713aa79ca8186ff18e6eba06a41b67062": "1d3ea4d0ce20ad3a766bf90a8bb22c08",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b2/29a86f77293fdcfd0017d4d27b86a9b0d588aa": "57fb5bac2fa2cf2899f4750c6bf8f2a3",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/a8/634861434b6ab6142fbf155b41ac0b53c6147e": "f45a591bbfebe10aa7aa69b7c1c208fc",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/ef/0fa712661348bdeef511b91cd6808c69c2c3ca": "91321b86e1896c1af22f77eb1f57105f",
".git/objects/ef/0b2dee10703c81da8009547f531b84a5f8e72a": "54dabef00dc90a1891e63df72d25e381",
".git/objects/95/740cfdaf6564561c0b47a7c6a76b16688ecf56": "3bcf49167f8dd3fbfb99cffae54a7c05",
".git/objects/1e/25fb4841dbfcbc6e4fa75d9417a4113ba250bc": "e91280155bc02e320c2a664e7fefc7b5",
".git/objects/33/bbb113fda405181818696de3c7f9487f6d8075": "771ced17201b7d11de95bc159fcf9f45",
".git/objects/d5/b2dece9e72727d96b64974f2c96813f66f8858": "9cc34a4fbd33dcd1f527b2a8be0b6a4f",
".git/objects/f3/222ca02384061aba38b129bcb832bc9e3d5679": "28d5a66f7b14565b238ec50251738782",
".git/objects/86/5ac83cfe7a0d8d067cf2462cc73e36c8f0d627": "22599b0062d6623619e6c6eaab9db754",
".git/objects/0c/7d36c0a884e7525a3caa6bafadc5777800dfff": "617ba793fc02e3bfd27033606e3f220a",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/db/74861cd1ab993738dc9d65cc8e2eacbb47d9d1": "47bccb49eeb238b9eb01d430cd05df61",
".git/objects/de/5341a41654b7043850a621b456f97ae4c2f7d3": "fabadea347580dbcbda5c6d59d8e23f9",
".git/objects/90/bcfcf0a77ab618a826db0fd8b0942963b653af": "fc109675cdf1233dd6599a4c3c0a7a69",
".git/objects/90/2f8508448fc861853f127ccebfe59a56a31122": "6c4195ff61f55d0e51d8851556d750fc",
".git/objects/09/93f94348c1bf4f73a2e743ec6fa9dd8c6fb558": "50ec767d1af708a68542dc0382c3c378",
".git/objects/5c/998507b8c54c75d8ac7e243fb5d14496d3540a": "b6d3cb09d65698fa598ce6b86d6587f0",
".git/objects/f6/6ab8c99cc4be534f725c75a5f93dd4f0bee029": "408e30905ac1168ee9bfb865e1fbc5da",
".git/objects/f8/95101a0e2f5ebc4f4a3004f4d62f6c9461bc5c": "8c0b26d8a1fde9dcb98acefad3f27eb5",
".git/objects/84/0516208d35dcb4298847ab835e2ef84ada92fa": "36a4a870d8d9c1c623d8e1be329049da",
".git/objects/aa/79128193af493c669fcd4f2df8643763ee82d8": "7da1aadb3862ff08a364ab60f391f126",
".git/objects/a3/787c42da175a7b9709385f609a7e5b4b34fc37": "553d2bf983005b3fccc58a5b4d02aa8f",
".git/objects/a2/c2c501d92cade4609fbff2a20d058036a0f07d": "5799cad65f96fe00122233a5625d5041",
".git/objects/99/b12fcd08eed06e178fdf32a93993b652951e7b": "1a24c70a08a24ae913c208b957be1c5b",
".git/objects/dc/aaefe207c24985bc4d2f52348045c8676b8154": "7f5bedf937f213aa75536a2738dd3082",
".git/objects/6e/443980efbb019578ed67e686a11aa7c79503b3": "d3bbf22262d54f6902367ef8e1e72277",
".git/objects/13/bde191cc57cfbb3da333837ec546b4a538ae6f": "1e68e4eff83684cf57d2f73c4bc202cd",
".git/objects/24/1ee447ab2fdb89248110c9ac2e21a0b106979e": "428f261c06f89da591f46e8d9d74ffca",
".git/objects/43/7270129a5c8089a67b8216b89a53e93447b28a": "165e4a126a7df6f41a76e34298435291",
".git/objects/43/11c527ac4ed759513411f2e627a29b840581ca": "eea8019957185d1b53477b753a734b40",
".git/objects/8a/0557fb5393f5c3af68db7a678f19e7aea74846": "46e8c213b57e1327a58657d82548efa3",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/3a/7525f2996a1138fe67d2a0904bf5d214bfd22c": "ab6f2f6356cba61e57d5c10c2e18739d",
".git/objects/75/0ce8504e974ddc6f26793565dff52ba2c703c6": "6ef6c260f72380e1993e0105034550ed",
".git/objects/4b/a1811ab322f1321fabaf73b493ddc553024a56": "c3a5b7a3d0e359fa6e51b95b9f107d04",
".git/objects/4b/036f4537a386e193c43be63378bd59fc04ff02": "8de0f7e05220f67fc5dec3172a1fd707",
".git/objects/98/57c9b3b0448c92818efc5fda0f206b21914168": "ecbde07c564dabbec0f249821051b8af",
".git/objects/1b/76c11d7addf1236661ee44e45d65a085563d23": "3a99e00170de6f5d6e41936766d3bf25",
".git/objects/1c/0f4648dfa818bb84c4e5fe54000bcb7acdbce9": "8f79d1e85db31c61060126234c3e8591",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"manifest.json": "f9d0789acb4352691ce0202a2a5418a6"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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