var cacheName = 'WeatherPWA-v3';        // Update Names whenever change in SW is done
var dataCacheName = 'weatherData-v3';
var filesToCache = ['/',
  '/index.html',
  '/scripts/app.js',
  '/scripts/localforage-1.4.0.js',
  '/styles/ud811.css',
  '/images/clear.png',
  '/images/cloudy-scattered-showers.png',
  '/images/cloudy.png',
  '/images/fog.png',
  '/images/ic_add_white_24px.svg',
  '/images/ic_refresh_white_24px.svg',
  '/images/partly-cloudy.png',
  '/images/rain.png',
  '/images/scattered-showers.png',
  '/images/sleet.png',
  '/images/snow.png',
  '/images/thunderstorm.png',
  '/images/wind.png'];

  var dataUrl = 'https://publicdata-weather.firebaseio.com/';

self.addEventListener('install',function(e){
  console.log('[ServiceWorker] install');         //function for caching the app shell & install the SW
  e.waitUntil(
    caches.open(cacheName).then(function(cache){
      console.log('[ServiceWorker] Caching App Shell');
      cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate',function(e)          //activate handler to update the cache
{
  console.log('[ServiceWorker] Activated');
  e.waitUntil(
    caches.keys().then(function(keyList)
    {
      return Promise.all(keyList.map(function (key)
      {
        if(key !== cacheName)
        {
            console.log('[ServiceWorker] Removing Old Cache', key);
            return caches.delete(key);
        }
      }));
    })
  )
});

self.addEventListener('fetch', function(e) {              // getting the app shell from the cache
    console.log('[ServiceWorker] Fetch ', e.request.url);
    if(e.request.url.startsWith(dataUrl)){
      e.respondWith(
        fetch(e.request)
        .then(function (response) {
          return caches.open(dataCacheName).then(function (cache) {
            cache.put(e.request.url, response.clone());
            console.log('[ServiceWorker] fetched & cached data');
            return response;
          });
        })
      );
    }
    else {
      e.respondWith(
        caches.match(e.request).then(function(response){
            return response || fetch(e.request);
        })
      );
    }
});
