CREATE DATABASE akademik_prodi;
USE akademik_prodi;

CREATE TABLE mahasiswa(
	nim INT NOT NULL,
	nama_mhs VARCHAR(50) NOT NULL,
	tgl_lahir DATE NOT NULL,
	alamat TEXT NOT NULL,
	email VARCHAR(45) NOT NULL,
	PRIMARY KEY(nim)
);
CREATE TABLE matakuliah(
	id_matakuliah INT NOT NULL,
	matakuliah VARCHAR(45) NOT NULL,
	sks INT,
	PRIMARY KEY(id_matakuliah)
	);
CREATE TABLE dosen(
	nrp_dosen INT,
	nama_dosen VARCHAR(50),
	email VARCHAR(45),
	PRIMARY KEY(nrp_dosen)
);
CREATE TABLE pengajar(
    nrp_dosen INT,
    id_matakuliah INT,
    PRIMARY KEY (nrp_dosen, id_matakuliah),
    FOREIGN KEY (nrp_dosen) REFERENCES dosen(nrp_dosen) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_matakuliah) REFERENCES matakuliah(id_matakuliah) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE kelas(
	idkelas INT NOT NULL,
	kelas VARCHAR(10) NOT NULL,`akademik`
	PRIMARY KEY(idkelas)
);
CREATE TABLE krs(
	idkrs INT NOT NULL AUTO_INCREMENT,
	id_matakuliah INT,
	nim INT,
	tahun VARCHAR(20)NOT NULL,
	semester INT NOT NULL,
	idkelas INT,
	PRIMARY KEY(idkrs),
	FOREIGN KEY(id_matakuliah) REFERENCES matakuliah (id_matakuliah) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(nim) REFERENCES mahasiswa (nim) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(idkelas) REFERENCES kelas (idkelas) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Mahasiswa VALUES
(23041, 'Andi Saputra', '2003-01-10', 'Jl. Merdeka No. 10', 'andi@universitas.ac.id'),
(23042, 'Adit Pramono', '2003-10-11', 'Jl. Merdeka No. 11', 'adit@universitas.ac.id'),
(23043, 'Cintia Bella', '2005-02-09', 'Jl. Merdeka No. 12', 'cintia@universitas.ac.id'),
(23044, 'Ayu Safitri', '2005-05-13', 'Jl. Merdeka No. 13', 'ayu@universitas.ac.id'),
(23045, 'Andreansyah', '2004-11-10', 'Jl. Merdeka No. 14', 'andre@universitas.ac.id'),
(23046, 'Putri Cantika', '2004-12-20', 'Jl. Merdeka No. 15', 'putri@universitas.ac.id'),
(23047, 'Bella', '2005-03-11', 'Jl. Merdeka No. 16', 'bella@universitas.ac.id'),
(23048, 'Safitri', '2005-11-20', 'Jl. Merdeka No. 17', 'safitri@universitas.ac.id'),
(23049, 'Wira Selfi', '2004-03-30', 'Jl. Merdeka No. 18', 'wira@universitas.ac.id'),
(23040, 'Laili Novi', '2003-04-19', 'Jl. Merdeka No. 20', 'laili@universitas.ac.id');
 
INSERT INTO dosen VALUES
(15674, 'Budi Bambang', 'budi@universitas.ac.id'),
(15671, 'Andika Pramono', 'andika@universitas.ac.id'),
(15672, 'Kartika', 'kartika@universitas.ac.id'),
(15675, 'Lestiana', 'letiana@universitas.ac.id'),
(15676, 'Chandra Permata', 'chandra@universitas.ac.id'),
(15677, 'Mustika Ratu', 'mustika@universitas.ac.id'),
(15678, 'Aditya Susilo', 'aditya@universitas.ac.id'),
(15679, 'Wardiansyah', 'wardiansyah@universitas.ac.id'),
(15670, 'Bento', 'bento@universitas.ac.id'),
(15673, 'Nouri Putri', 'nouri@universitas.ac.id');

INSERT INTO matakuliah VALUES
(101, 'Pemrograman Dasar', 3),
(102, 'Struktur Data', 3),
(103, 'Basis Data', 3),
(104, 'Sistem Operasi', 3),
(105, 'Jaringan Komputer', 2),
(106, 'Algoritma dan Pemrograman', 3),
(107, 'Kalkulus', 2),
(108, 'Kecerdasan Buatan', 3),
(109, 'Pemrograman Web', 3),
(110, 'Etika Profesi', 2);

INSERT INTO kelas VALUES
(1, 'TI-1A'),
(2, 'TI-1B'),
(3, 'TI-2A'),
(4, 'TI-2B'),
(5, 'TI-3A');

INSERT INTO pengajar (nrp_dosen, id_matakuliah) VALUES
(15674, 101),
(15671, 102),
(15672, 103),
(15675, 104),
(15676, 105);

INSERT INTO krs (id_matakuliah, nim, tahun, semester, idkelas) VALUES
(101, 23041, '2024/2025', 2, 1),
(102, 23042, '2024/2025', 2, 2),
(103, 23043, '2024/2025', 2, 3),
(104, 23044, '2024/2025', 2, 4),
(105, 23045, '2024/2025', 2, 5);

SELECT * FROM mahasiswa;
SELECT * FROM mata_kuliah;
SELECT * FROM pengajar;
SELECT * FROM dosen;
SELECT * FROM kelas;
SELECT * FROM krs;

RENAME TABLE matakuliah TO mata_kuliah;

DROP DATABASE akademik_prodi;
