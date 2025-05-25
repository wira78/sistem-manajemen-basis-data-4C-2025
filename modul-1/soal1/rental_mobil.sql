CREATE DATABASE rental_mobil;
USE rental_mobil;

CREATE TABLE mobil(
	platnomor INT NOT NULL,
	harga_rental FLOAT NOT NULL,
	warna VARCHAR(45) NOT NULL,
	tahun YEAR NOT NULL,
	PRIMARY KEY(platnomor)
);

CREATE TABLE user_pelanggan(
	iduser INT NOT NULL AUTO_INCREMENT,
	nama VARCHAR(45) NOT NULL,
	alamat TEXT NOT NULL,
	jenis_kelamin ENUM('P', 'L')NOT NULL,
	no_hp VARCHAR(45)NOT NULL,
	no_ktp VARCHAR(45)NOT NULL,
	email VARCHAR(45) NOT NULL,
	PRIMARY KEY(iduser)
);

CREATE TABLE rental(
	id_rental INT AUTO_INCREMENT,
	tgl_rental DATE NOT NULL,
	tgl_kembali DATE NOT NULL,
	tgl_pengembalian DATE NOT NULL,
	platnomor INT NOT NULL,
	iduser INT NOT NULL,
	PRIMARY KEY(id_rental),
	FOREIGN KEY(platnomor) REFERENCES mobil (platnomor) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(iduser) REFERENCES user_pelanggan (iduser) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pegawai(
	idpegawai INT NOT NULL AUTO_INCREMENT,
	nama VARCHAR(45) NOT NULL,
	jabatan VARCHAR(45) NOT NULL,
	no_hp VARCHAR(45) NOT NULL,
	atasan_id INT NOT NULL,
	PRIMARY KEY(idpegawai)
);

CREATE TABLE transaksi(
	idtransaksi INT NOT NULL,
	tgl_bayar DATE NOT NULL, 
	jumlah_bayar FLOAT NOT NULL,
	metode_pembayaran VARCHAR(45) NOT NULL,
	status_pembayaran VARCHAR(45) NOT NULL,
	idpegawai INT NOT NULL,
	id_rental INT NOT NULL,
	PRIMARY KEY(idtransaksi),
	FOREIGN KEY(idpegawai) REFERENCES pegawai (idpegawai) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(id_rental) REFERENCES rental (id_rental) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE denda (
    iddenda INT NOT NULL AUTO_INCREMENT,
    id_rental INT NOT NULL,
    tgl_denda DATE NOT NULL,
    jumlah_denda FLOAT NOT NULL,
    keterangan VARCHAR(100),
    PRIMARY KEY (iddenda),
    FOREIGN KEY (id_rental) REFERENCES rental(id_rental) ON DELETE CASCADE ON UPDATE CASCADE
); 

INSERT INTO mobil (platnomor, harga_rental, warna, tahun) VALUES
(1234, 300000, 'Hitam', 2020),
(5678, 350000, 'Putih', 2021),
(9012, 400000, 'Merah', 2022);

INSERT INTO user_pelanggan (nama, alamat, jenis_kelamin, no_hp, no_ktp, email) VALUES
('Andi Saputra', 'Jl. Merdeka No.1', 'L', '081234567890', '3275010101010001', 'andi@email.com'),
('Dina Lestari', 'Jl. Sudirman No.10', 'P', '081298765432', '3275020202020002', 'dina@email.com');

INSERT INTO pegawai (nama, jabatan, no_hp) VALUES
('Budi Santoso', 'Admin', '081212121212'),
('Rina Kartika', 'Kasir', '081313131313');

INSERT INTO rental (tgl_rental, tgl_kembali, tgl_pengembalian, platnomor, iduser) VALUES
('2025-04-01', '2025-04-03', '2025-04-03', 1234, 1),
('2025-04-02', '2025-04-05', '2025-04-05', 5678, 2);

INSERT INTO transaksi (idtransaksi, tgl_bayar, jumlah_bayar, metode_pembayaran, status_pembayaran, idpegawai, id_rental) VALUES
(1, '2025-04-01', 600000, 'Transfer', 'Lunas', 2, 1),
(2, '2025-04-02', 1050000, 'Tunai', 'Lunas', 2, 2);

SELECT * FROM mobil;
SELECT * FROM pegawai;
SELECT * FROM user_pelanggan;
SELECT * FROM rental;
SELECT * FROM transaksi;

DROP DATABASE rental_mobil;
