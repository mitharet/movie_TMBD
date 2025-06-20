# 🎬 movieTMBD

movieTMBD adalah aplikasi Flutter yang menampilkan daftar film dari [TMDB API](https://developer.themoviedb.org/) dengan antarmuka yang sederhana dan intuitif.

## 🚀 Fitur Utama

- Menampilkan daftar film populer
- Melihat detail film
- Menyimpan film favorit
- Mencari film berdasarkan kata kunci

## 🛠️ Teknologi yang Digunakan

- **Flutter** 3.22.3
- **GetX** – untuk state management dan navigasi
- **HTTP** – untuk fetching data dari TMDB
- **flutter_native_splash** – splash screen saat aplikasi dibuka

## 📂 Struktur Proyek

```
lib/
├── core/
│   └── service/            # Service HTTP ke TMDB dan init Hive
├── feature/
│   ├── movie_list/
│   │   ├── controllers/  # Logic dan state GetX
│   │   ├── models/       # Model data (Movie, MovieDetail, dsb)
│   │   └── views/        # Widget dan UI untuk list/detail movie
│   ├── movie_detail/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── views/
│   ├── movie_search/
│   │   ├── controllers/
│   │   └── views/
│   ├── movie_favorite/
│   │   ├── controllers/
│   │   └── views/
├── main.dart             # Entry point aplikasi
```

## 🧪 Menjalankan Aplikasi

1. Pastikan Flutter versi 3.22.3 terinstal.
2. Clone proyek ini:

   ```bash
   git clone https://github.com/username/movieTMBD.git
   cd movieTMBD
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## 🔑 API Key

Proyek ini menggunakan API key dari [TMDB](https://www.themoviedb.org/) yang **disimpan langsung di dalam file service** (misalnya di `lib/feature/movie_list/services/movie_service.dart`) seperti ini:

```dart
const String apiKey = 'YOUR_TMDB_API_KEY';
```

Kemudian digunakan saat memanggil endpoint TMDB:

```dart
final url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
```

> ⚠️ **Catatan:** Jadi tinggal ambil API Key sendiri ya untuk testnya.

## 📄 Lisensi

MIT License – bebas digunakan dan dimodifikasi.
