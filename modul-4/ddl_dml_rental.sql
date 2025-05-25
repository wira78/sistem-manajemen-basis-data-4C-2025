-- mnambahkan atribut baru
ALTER TABLE denda 
ADD COLUMN keterangan TEXT;
-- gabungan 2 tabel
SELECT 
    r.id_rental,
    p.nama,
    r.tgl_rental,
    r.tgl_kembali,
    r.tgl_pengembalian,
    r.platnomor,
    d.tgl_denda,
    d.jumlah_denda
FROM rental r
JOIN user_pelanggan p ON r.iduser = p.iduser
LEFT JOIN denda d ON r.id_rental = d.id_rental;
-- denda
SELECT * FROM denda
ORDER BY tgl_denda DESC;
-- mobil
SELECT * FROM mobil
ORDER BY harga_rental ASC;
-- rental
SELECT * FROM rental
ORDER BY tgl_pengembalian DESC, tgl_rental ASC;
-- pegawai
SELECT * FROM pegawai
ORDER BY nama DESC;
-- user_pelanggan
SELECT * FROM user_pelanggan
ORDER BY nama ASC;
-- transaksi
SELECT * FROM transaksi
ORDER BY tgL_bayar ASC;
-- pengubahan tipedata
ALTER TABLE rental 
ALTER COLUMN platnomor VARCHAR(15);
-- LEFT JOIN
SELECT user_pelanggan.nama, rental.tgl_rental
FROM user_pelanggan
LEFT JOIN rental ON user_pelanggan.iduser = rental.iduser;

-- RIGHT JOIN
SELECT transaksi.idtransaksi, pegawai.nama
FROM pegawai
RIGHT JOIN transaksi ON pegawai.idpegawai = transaksi.idpegawai;

-- SELF JOIN
ALTER TABLE pegawai ADD atasan_id INT;
SELECT p1.nama AS pegawai, p2.nama AS atasan
FROM pegawai p1
LEFT JOIN pegawai p2 ON p1.atasan_id = p2.idpegawai;

SELECT * FROM rental WHERE tgl_kembali> 2023; 
SELECT * FROM rental WHERE tgl_kembali < tgl_pengembalian;
SELECT * FROM rental WHERE platnomor != 1234;
SELECT * FROM rental WHERE iduser BETWEEN 1 AND 1003;
SELECT * FROM rental WHERE id_rental IN (2, 4, 6);
