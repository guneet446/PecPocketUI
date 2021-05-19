'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "5954cdd5748ac90981ef73ac4ec12759",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "e753b1b2fbdd463df6d52db768559291",
"/": "e753b1b2fbdd463df6d52db768559291",
"main.dart.js": "173fd2a56ab8e9fed756b8fd7c6c7846",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/AssetManifest.json": "73c167ba22444be265b0b7bf1280102b",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/timezone/data/2020a.tzf": "84285f1f81b999f1de349a723574b3e5",
"assets/assets/028-woman.png": "d470d442c978de0549b215f86a512c47",
"assets/assets/26.png": "d3a53404a3c95845eea57deb8b939983",
"assets/assets/45.png": "acb14783f06dce584a0817ee81782868",
"assets/assets/5.png": "7d49a78e150fa6d2bbd1b8a94dd365a8",
"assets/assets/22.png": "998d1bae6ccd9f51d66578ea29426585",
"assets/assets/030-woman.png": "a893e3791e4b2ddaa1ca6b5ffd4fc68d",
"assets/assets/50.png": "83de986ee601f8521bfbe5159d0ba3b3",
"assets/assets/29.png": "5d0bf2bc240d9546b8c910e044116fab",
"assets/assets/44.png": "beb3b8b72914f7b938cf132498dd6d69",
"assets/assets/14.png": "5a42b539f22d3a8307d159b90ad2988a",
"assets/assets/001-woman.png": "4b118564260f1a965510d8a639913ad9",
"assets/assets/logout.png": "2866f3d528fc1b46801f482d49fc3d2b",
"assets/assets/033-woman.png": "8064527ecc14ad906769486193bac5ee",
"assets/assets/23.png": "36d3c9783bbf35f9cf2c4a1c8ac8294e",
"assets/assets/018-woman.png": "665ef1e405c9b7a2ded1d2c700983c93",
"assets/assets/038-man.png": "e954e1be779073145a385c8ef95e7e3d",
"assets/assets/021-man.png": "89fbf2711976d7ed97a42083df478dbd",
"assets/assets/studymaterial.png": "b808452add93797a7c33e86200c3d645",
"assets/assets/20.png": "9e00a32e685a757be37ba8f44f90a30f",
"assets/assets/53.png": "ee6b4293f48d037b2da0b48e9d43a852",
"assets/assets/Pecsocial.png": "291b9b0dfe2e1f52185dbd46cfde1c80",
"assets/assets/33.png": "1213e61e3a91b48b20666d1e727a4322",
"assets/assets/image.png": "51d9ad24586e3da62bb2ed625480c399",
"assets/assets/042-woman.png": "3f8d64fd26598dde73750c95ae4eb1ef",
"assets/assets/031-woman.png": "3ab5bdd74dd6ce8583af61b56dbc1160",
"assets/assets/014-man.png": "a1f4210d90ee305bf5242e6984a7865b",
"assets/assets/36.png": "75d018e295338b953db6d47b6087d4ab",
"assets/assets/study_material.png": "627bf0407e3ee112634fc518bdbe1ddf",
"assets/assets/35.png": "05bade2de4febdb93c6feb8cb4d2b093",
"assets/assets/signup.png": "7b5eaf1479ab82e1faa970e34821df28",
"assets/assets/024-man.png": "3eecb56b22eac712ee7e8011798458a7",
"assets/assets/55.png": "9684384115dfe1171c0aa76baa229dec",
"assets/assets/050-woman.png": "57d3daa8b5fabd05ad4ed9b29a3984fb",
"assets/assets/32.png": "8cf74508aa5e10b6748a8ef9604f3c24",
"assets/assets/pec_social.png": "90badfb96bdacc339b1d14784d5c79a0",
"assets/assets/40.png": "b18e78a66ba837d09f83981043b205d3",
"assets/assets/17.png": "6c03e06b0deb6039c216daa349d7c9c2",
"assets/assets/016-woman.png": "caf0351ebd891af5f72e902968902876",
"assets/assets/035-woman.png": "0c3122b0ca9841957cda7c5b46a117e6",
"assets/assets/neutral_girl.png": "07b28fb921a953c3b0ffef97bf219d3c",
"assets/assets/instagram_logo.png": "47c386c181608eded7f32ff08deafcbc",
"assets/assets/47.png": "ba69e1bfab835df801cc4f447eddeb59",
"assets/assets/045-woman.png": "65cdca1198f4fdf73545e26262dd66e4",
"assets/assets/034-man.png": "8c75b70bce2f59ab029fd165563896f0",
"assets/assets/005-man.png": "073fc8bade96b94d393461aaa4168214",
"assets/assets/006-woman.png": "df13a026995c5801cbce9a867fe86da5",
"assets/assets/8.png": "d1dced4878279182a62687992e747bb0",
"assets/assets/009-woman.png": "800593c4be96b9ada3806cdbff86bdaf",
"assets/assets/010-woman.png": "322f7a2444d6124a273f4ca7219b198d",
"assets/assets/041-man.png": "9a56e3d896610467cceee58e65acb093",
"assets/assets/clubs.png": "20e2bc102156d83ee0198e0eedc9f42e",
"assets/assets/046-woman.png": "4c0d0134feedd0936e00fd73385c96a5",
"assets/assets/25.png": "8c6820fd80eb53311bac1368a7294369",
"assets/assets/31.png": "279d72016ea1675dfdfcc6c01aad5a3d",
"assets/assets/7.png": "69ecfe73462fcf89d3dd547fadd87eb2",
"assets/assets/custom_reminders.png": "54f503dc22729102c6111207a221a4c7",
"assets/assets/bg1.png": "734de1a07dcaf0ecf7e5e6f1fd7a0e97",
"assets/assets/12.png": "9c0841bea84f6db802d6c9ff4bd90819",
"assets/assets/026-man.png": "1c8cd744e13b8def5043f54f09969caf",
"assets/assets/037-woman.png": "350b4cad6980dfe923c31bb8b170c9f9",
"assets/assets/036-man.png": "71584bbdb0b0c1678cd65c2ec66b939c",
"assets/assets/43.png": "aa8b87455cf75b2fff95253b3a62f322",
"assets/assets/10.png": "2689d30843985a564f8fbae78499bab0",
"assets/assets/019-man.png": "ad73addb7621d2d240a8cc5d1bc61462",
"assets/assets/password.png": "a59d86a5e7fab3a47c3fc34990732034",
"assets/assets/043-woman.png": "a01a5d9aabf34c909546095d2aaea45e",
"assets/assets/42.png": "3d51b6157636f6b6bdab1a6a0ff8fe6c",
"assets/assets/34.png": "4c6e93e197c519e2425d7c36693c8233",
"assets/assets/27.png": "3f01149eb2d332f927e73ed81d4b21e6",
"assets/assets/9.png": "44b6524bc3bd1f0e2c7d0bc30adea930",
"assets/assets/custom_reminder.png": "287bce88f85da0f9f7351ca258175757",
"assets/assets/21.png": "a2f3e3edfa9c39a2895c96d1514762ca",
"assets/assets/049-man.png": "a3e90cd424e77e6bfb98d9f0ebafca9a",
"assets/assets/30.png": "44489fe330ad38d252aba2c9accf6714",
"assets/assets/025-woman.png": "8a9e3f4515d1eea9fb742209d5b68056",
"assets/assets/040-woman.png": "aa3da690ee7c25f620dbcf432938af3b",
"assets/assets/noti.png": "3bffaa5239d28c1e6ab408b7097b63a7",
"assets/assets/047-woman.png": "536c5ab40b568c3fb8440ad35b1314fb",
"assets/assets/007-woman.png": "e4bd0737ce29921fc03bcc66750c093a",
"assets/assets/2.png": "186e10a82dc5053abda4b49c190ca744",
"assets/assets/timetable.png": "613541de8c009bcc8152ce34775c3ac7",
"assets/assets/52.png": "8a6073e763c9246de8c7266c41e1b631",
"assets/assets/pdf-file.png": "7f72e1e8868a6a38c50734a9d761c5e5",
"assets/assets/11.png": "a344cd2b309f8b4c3b9344bb6ae96d78",
"assets/assets/6.png": "cd2c90537550dd6e3ca0363d1078535d",
"assets/assets/folder.png": "0fc96e48dd23666f1ecc8491866ddf55",
"assets/assets/delete.png": "52bc1a3bc0bea249372da61f5d40320e",
"assets/assets/46.png": "de8727c4d14220127a5cdcf649909c1b",
"assets/assets/19.png": "0376d7c8d65761d4b2303736ae94cb4c",
"assets/assets/54.png": "5271b3d6a1f56267659ee9443f948aa8",
"assets/assets/039-woman.png": "8b0569547b3dca998f0df1346d0e98e8",
"assets/assets/16.png": "bed6f0139f915af722d100d1f7dfe4e6",
"assets/assets/instagram.png": "0634a5babf36db50e415356b348e3f30",
"assets/assets/56.png": "02f3a82931fc033852b0c468fc91dfbb",
"assets/assets/013-man.png": "0d8025a2dca35f6293a375bfb9b16834",
"assets/assets/029-man.png": "45ca6dd8067dd2ab794d9e470bf3643f",
"assets/assets/49.png": "484ec4b66f94ce70256d19add7c40623",
"assets/assets/28.png": "c3e61e0b71d3ee3e6b9ff3b438fdb912",
"assets/assets/37.png": "fc4cf13444998173176052389a96c221",
"assets/assets/004-woman.png": "ac96885e8c6f36de1d5c7466ce987365",
"assets/assets/attendance.png": "e9ac53a1c88df041e3c685cab0b723ac",
"assets/assets/3.png": "cbb6bd7e195213514b3969a5d355e0e9",
"assets/assets/003-woman.png": "90b0b2c6d45c2ae7a8607aa2553f391f",
"assets/assets/032-man.png": "a3e9e9a488eaa9402085a3169194f034",
"assets/assets/027-woman.png": "6a01f7820c44aafc2cb86111db1dbfbe",
"assets/assets/39.png": "5dc1b010fd70f8f105acf5607ba688a3",
"assets/assets/51.png": "d0d450b8ca4b69be1e79359c0061a88b",
"assets/assets/24.png": "669d40e3bc085f88efbfac02280dfe2c",
"assets/assets/022-woman.png": "ceade7ba630c2889c4c30fa79cf09d87",
"assets/assets/neutral_guy.png": "83de986ee601f8521bfbe5159d0ba3b3",
"assets/assets/neutral.png": "18b70aeece1a255271405a969edc08ad",
"assets/assets/023-woman.png": "eafba9aacb34d2c5547b08eec927288c",
"assets/assets/044-woman.png": "926dbbb1be687cf1db56ba26b2a09892",
"assets/assets/011-man.png": "e74d8cfe0d9340737dc2b66e6381443e",
"assets/assets/15.png": "a0677b7b3ca94d9ced1448ca7bdedf66",
"assets/assets/13.png": "47cfbce03c75e491e4442107a38ae45a",
"assets/assets/017-woman.png": "b76cf1a9e7b6ecfc4f5afeee217294ba",
"assets/assets/attendance_placeholder.png": "2971cc6bc8e4494d59d2f7d5c216427e",
"assets/assets/bg2.png": "cb47f9a5852466f4cda6cec8e23cc996",
"assets/assets/18.png": "58cd86cfe56a3903e3f2579cb1b148cf",
"assets/assets/4.png": "af0ba23d01e3347b380c21329ac32c57",
"assets/assets/020-man.png": "9c7a5a1076256ea1d21ac3fc56f48150",
"assets/assets/38.png": "7b309a489f9122146481e75102bae871",
"assets/assets/008-woman.png": "74f6c4214aa6e3484d74babe491f657b",
"assets/assets/002-man.png": "86d9a87b262e90f5d3d01267a4a6233a",
"assets/assets/1.png": "81c53f3390f96c2b4b1a0da114fb0a99",
"assets/assets/048-woman.png": "8c270c9b4cfeb651c4466447735872c4",
"assets/assets/48.png": "59768887fd346484f223ce04565579c2",
"assets/assets/subjects.png": "ad021ae46a13d103b71d0a4bb7e11c9c",
"assets/assets/015-woman.png": "2dd114925b4adde0c10825024873b364",
"assets/assets/012-woman.png": "d1e6d910baa3c314417be5976b2f1f59",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "119cda99c979969034951ae440bd2980",
"version.json": "7bcb57068b1ae2127f3f627a5c984794"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
