# Mobile Engineer Home Test Overview

## Aplikasi
Aplikasi ini dibuat untuk memenuhi requirement Home Test Mobile Engineer dengan fitur utama sebagai berikut:

1. **Movie List (Now Playing)**
   - Menampilkan daftar movie "Now Playing" dengan pagination untuk pengalaman browsing yang mulus.
   - Pencarian movie dengan data yang ada.
   - Data diambil dari TMDB API dengan caching menggunakan Hive untuk akses offline.

2. **Movie Search**
   - Pencarian movie dengan data yang tersimpan secara lokal menggunakan Hive.
   - Implementasi debounce untuk menghindari banyak request dan mengurangi beban API.

3. **Movie Detail**
   - Halaman detail movie yang menampilkan informasi lengkap dari API, termasuk sinopsis, rating, dan tanggal rilis.

4. **Favorite Movie**
   - Menyimpan movie favorit secara offline menggunakan Hive.
   - Mendukung penambahan dan penghapusan movie dari daftar favorit.

## Struktur Project

### Core
- **Service**
  - Mengelola service HTTP TMDB dan inisialisasi Hive.

### Feature
- **Movie List**
  - Menampilkan daftar movie dengan pagination dan integrasi Hive untuk caching.

- **Movie Search**
  - Mengelola fitur pencarian movie dengan debounce untuk menghindari banyak request.

- **Movie Detail**
  - Halaman detail movie, menampilkan informasi lengkap dari API.

- **Movie Favorite**
  - Fitur favorite movie yang memungkinkan pengguna menyimpan dan melihat movie favorit secara offline.

## Alasan Desain dan Teknologi
- **GetX** dipilih untuk state management karena kemudahan penggunaan, reaktivitas, dan integrasi dengan routing.
- **Hive** dipilih untuk local storage karena performa cepat, mudah integrasi dengan Flutter, dan support tipe data custom.
- Struktur fitur dipisah menjadi modul yang jelas agar lebih maintainable dan scalable.
- Menjaga clean architecture sederhana supaya mudah dikembangkan dan diuji.

## Fitur Tambahan
- Caching data movie menggunakan Hive sehingga aplikasi tetap dapat menampilkan data saat offline.
- Optimasi UI agar responsif di berbagai ukuran layar.

## Unit Testing (Belum Diimplementasi)
- **MovieController Unit Test**
  - Fokus pada logika pencarian dan pemrosesan data dari Hive.
  - Menggunakan `hive_test` untuk mock Hive database saat testing agar tidak mengganggu data asli.

## Catatan untuk Pengembangan Lanjutan
- Menambahkan unit test untuk memastikan stabilitas aplikasi.
- Memperluas fitur pencarian dengan rekomendasi dan history pencarian.
- Integrasi dengan analitik untuk tracking penggunaan aplikasi.
