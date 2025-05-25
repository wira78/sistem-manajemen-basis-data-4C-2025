CREATE DATABASE data_umkm_jabar;
USE data_umkm_jabar;

CREATE TABLE produk_umkm(
	id_produk INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_umkm INT(11),
	nama_produk VARCHAR(200),
	harga DECIMAL(15.2),
	deskripsi_produk TEXT,
	FOREIGN KEY(id_umkm) REFERENCES umkm (id_umkm) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE pemilik_umkm(
	id_pemilik INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nik VARCHAR(16),
	nama_lengkap VARCHAR(200),
	jenis_kelamin ENUM('Laki-laki', 'Perempuan'),
	alamat TEXT,
	nomor_telepon VARCHAR(15),
	email VARCHAR(100)	
);
CREATE TABLE kategori_umkm(
	id_kategori INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama_kategori VARCHAR(100),
	deskripsi TEXT
);
CREATE TABLE umkm(
	id_umkm INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama_usaha VARCHAR(200),
	id_pemilik INT(11),
	id_kategori INT(11),
	id_skala INT(11),
	id_kabupaten_kota INT(11),
	alamat_usaha TEXT,
	nik VARCHAR(50),
	npwp VARCHAR(20),
	tahun_berdiri YEAR(4),
	jumlah_karyawan INT(11),
	total_aset DECIMAL(15.2),
	omzet_per_tahun DECIMAL(15.2),
	deskripsi_usaha TEXT,
	tanggal_regristasi DATE,
	FOREIGN KEY(id_pemilik) REFERENCES pemilik_umkm (id_pemilik) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_kategori) REFERENCES kategori_umkm (id_kategori) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_skala) REFERENCES skala_umkm (id_skala) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_kabupaten_kota) REFERENCES kabupaten_kota (id_kabupaten_kota) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE skala_umkm(
	id_skala INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama_skala VARCHAR(50),
	batas_aset_bawah DECIMAL(15.2),
	batas_aset_atas DECIMAL(15.2),
	batas_omzet_bawah DECIMAL(15.2),
	batas_omzet_atas DECIMAL(15.2)
);
CREATE TABLE kabupaten_kota(
	id_kabupaten_kota INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama_kabupaten_kota VARCHAR(100)
);

CREATE VIEW view_umkm_detail AS
SELECT 
	u.nama_usaha, 
	p.nama_lengkap AS nama_pemilik,
	k.nama_kategori,
	s.nama_skala,
	kk.nama_kabupaten_kota,
	u.tahun_berdiri
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id_kabupaten_kota

SELECT * FROM view_umkm_detail;

CREATE VIEW view_pemilik_dan_usaha AS
SELECT
	p.nik,
	p.nama_lengkap,
	p.jenis_kelamin,
	p.nomor_telepon,
	p.email,
	u.nama_usaha
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik

DROP VIEW view_pemilik_dan_usaha;

SELECT * FROM view_pemilik_dan_usaha;

CREATE VIEW view_produk_umkm AS
SELECT 
	u.nama_usaha,
	p.nama_produk,
	p.deskripsi_produk,
	p.harga
FROM produk_umkm p
JOIN umkm u ON p.id_umkm = u.id_umkm
SELECT * FROM view_produk_umkm;

CREATE VIEW view_umkm_menengah AS
SELECT 
	u.nama_usaha,
	p.nama_lengkap AS nama_pemilik,
	u.total_aset,
	u.omzet_per_tahun  
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik

SELECT * FROM view_umkm_menengah;

CREATE VIEW view_umkm_per_kota AS 
SELECT 
	kk.nama_kabupaten_kota AS nama_kabupaten_kota,
	COUNT(um.id_umkm) AS jumlah_umkm
	FROM umkm um
	JOIN kabupaten_kota kk ON um.id_kabupaten_kota = kk.id_kabupaten_kota
	GROUP BY kk.nama_kabupaten_kota;
