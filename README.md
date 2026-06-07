# Aplikasi Portofolio Pribadi

Aplikasi mobile portofolio pribadi yang dibangun menggunakan Flutter sebagai tugas praktikum Pemrograman Mobile.

## Identitas

Keterangan  Detail
Nama Raka Adrian H 
NIM 123103015 
Jurusan Teknik Informatika 
Angkatan 2023 

## Deskripsi Aplikasi

Aplikasi ini menampilkan informasi pribadi, portofolio project, dan kontak dalam tampilan mobile yang modern dan elegan.

## Fitur

- Tab About Me= informasi diri dan keahlian
- Tab Portfolio=  daftar project dengan halaman detail
- Tab Contact= informasi kontak
- Halaman detail portfolio (Navigator.push)
- Animasi transisi antar tab
- Tema warna Navy dan Gold

## Pengembangan yang Dipilih

### (A) Tambah Halaman Baru
Menambahkan halaman `DetailPorto` yang dapat diakses dari tab Portfolio menggunakan `Navigator.push()`. Setiap card portfolio dapat diklik untuk melihat deskripsi lengkap dan fitur-fitur project.

### (C) Ubah Tema Warna
Mengubah skema warna aplikasi menjadi kombinasi **Navy (#0F172A)** dan **Gold (#F59E0B)** yang diterapkan secara konsisten di seluruh halaman.

### (D) Tambah Animasi
Menambahkan animasi `FadeTransition` dan `SlideTransition` saat berpindah tab, serta `Hero` animation pada icon portfolio saat berpindah ke halaman detail.

## Teknologi

- Flutter
- Dart
- Material Design 3

## Screenshot

About Me, Portfolio, Contact
![About](screenshot/tab_about.png), ![Porto](screenshot/tab_porto.png), ![Contact](screenshot/tab_contact.png)