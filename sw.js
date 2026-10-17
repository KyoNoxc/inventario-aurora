// Service worker de Inventario Aurora
// - La página se pide siempre a la red primero, así las actualizaciones llegan solas.
// - Si no hay señal, se abre la última copia guardada.
// - Los datos (Supabase) nunca se guardan aquí: siempre vienen frescos de la base de datos.

const CACHE = 'inventario-aurora-v1';
const SHELL = ['./', 'index.html', 'manifest.json', 'icon-192.png', 'icon-512.png', 'apple-touch-icon.png'];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);

  // Los datos de Supabase no se tocan
  if (url.hostname.endsWith('.supabase.co')) return;

  // Página principal: red primero, copia guardada si no hay señal
  if (req.mode === 'navigate') {
    event.respondWith(
      fetch(req, { cache: 'no-cache' })
        .then(res => {
          if (res.ok) {
            const copy = res.clone();
            caches.open(CACHE).then(c => c.put('index.html', copy));
          }
          return res;
        })
        .catch(() => caches.match('index.html'))
    );
    return;
  }

  // Archivos de la app y la librería de Supabase: copia guardada primero, se refresca en segundo plano
  if (url.origin === self.location.origin || url.hostname === 'unpkg.com') {
    event.respondWith(
      caches.match(req).then(cached => {
        const network = fetch(req)
          .then(res => {
            if (res && (res.ok || res.type === 'opaque')) {
              const copy = res.clone();
              caches.open(CACHE).then(c => c.put(req, copy));
            }
            return res;
          })
          .catch(() => cached);
        return cached || network;
      })
    );
  }
});
