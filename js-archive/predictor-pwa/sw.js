var cacheName = 'predictor-v32';
var filesToCache = ['/',
  './images/icons/predictor32.png',
  './images/icons/predictor64.png',
  './images/icons/predictor128.png',
  './images/icons/predictor256.png',
  './images/icons/predictor512.png',
  './index.html',
  './script/app.js',
  './script/dialog-polyfill.min.js',
  './style/dialog-polyfill.min.css',
  './style/material.min.css',
  './style/mystyle.css',
  './script/jquery.min.js',
  './script/material.min.js'];

self.addEventListener('install',function(e){
  //console.log('[ServiceWorker] install');         //function for caching the app shell & install the SW
  e.waitUntil(
    caches.open(cacheName).then(function(cache){
      //console.log('[ServiceWorker] Caching App Shell');
      cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate',function(e)          //activate handler to update the cache
{
  var cacheWhiteList = ['predictor-v32'];
  
  //console.log('[ServiceWorker] Activated');
  e.waitUntil(
    caches.keys().then(function(keyList)
    {
      return Promise.all(keyList.map(function (key)
      {
       
        if(cacheWhiteList.indexOf(key) === -1)
        {
          return caches.delete(key);
        }
        
      }));
    })
  )
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Cache hit - return response
        if (response) {
          return response;
        }

        // IMPORTANT: Clone the request. A request is a stream and
        // can only be consumed once. Since we are consuming this
        // once by cache and once by the browser for fetch, we need
        // to clone the response.
        var fetchRequest = event.request.clone();

        return fetch(fetchRequest).then(
          function(response) {
            // Check if we received a valid response
            if(!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }

            // IMPORTANT: Clone the response. A response is a stream
            // and because we want the browser to consume the response
            // as well as the cache consuming the response, we need
            // to clone it so we have two streams.
            var responseToCache = response.clone();

            caches.open(cacheName)
              .then(function(cache) {
                cache.put(event.request, responseToCache);
              });

            return response;
          }
        );
      })
    );
});
