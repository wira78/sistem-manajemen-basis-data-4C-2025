CREATE VIEW vw_rental_mobil AS
SELECT 
    r.id_rental,
    m.platnomor,
    m.warna,
    m.tahun,
    r.tgl_rental,
    r.tgl_kembali,
    r.tgl_pengembalian
FROM rental r
JOIN mobil m ON r.platnomor = m.platnomor;

SELECT * FROM vw_rental_mobil;

CREATE VIEW vw_rental_mobil_pelanggan AS
SELECT 
	    r.id_rental,
	    u.nama AS nama_pelanggan,
	    u.no_hp,
	    m.platnomor,
	    m.warna,
	    m.tahun,
	    r.tgl_rental,
	    r.tgl_kembali,
	    r.tgl_pengembalian
FROM rental r
JOIN user_pelanggan u ON r.iduser = u.iduser
JOIN mobil m ON r.platnomor = m.platnomor;

SELECT * FROM vw_rental_mobil_pelanggan;

CREATE VIEW View_Rental_Lunas AS
SELECT 
    r.id_rental,
    u.nama AS nama_pelanggan,
    u.no_hp,
    m.platnomor,
    m.warna,
    m.tahun,
    r.tgl_rental,
    r.tgl_kembali,
    r.tgl_pengembalian,
    t.tgl_bayar,
    t.jumlah_bayar,
    t.metode_pembayaran,
    t.status_pembayaran
FROM rental r
JOIN user_pelanggan u ON r.iduser = u.iduser
JOIN mobil m ON r.platnomor = m.platnomor
JOIN transaksi t ON r.id_rental = t.id_rental
WHERE t.status_pembayaran = 'Lunas';

SELECT * FROM View_rental_lunas;

CREATE VIEW vw_total_denda_per_pelanggan AS
SELECT 
    u.nama AS nama_pelanggan,
    COUNT(d.iddenda) AS jumlah_keterlambatan,
    SUM(d.jumlah_denda) AS total_denda
FROM denda d
JOIN rental r ON d.id_rental = r.id_rental
JOIN user_pelanggan u ON r.iduser = u.iduser
GROUP BY u.nama;

SELECT * FROM vw_total_denda_per_pelanggan;

CREATE VIEW view_transaksi_keseluruhan AS
SELECT 
	    t.idtransaksi,
	    t.tgl_bayar,
	    t.jumlah_bayar,
	    t.metode_pembayaran,
	    t.status_pembayaran,
	    p.nama AS nama_pegawai,
	    u.nama AS nama_pelanggan,
	    m.platnomor,
	    m.warna,
	    r.tgl_rental,
	    r.tgl_pengembalian
FROM transaksi t
JOIN pegawai p ON t.idpegawai = p.idpegawai
JOIN rental r ON t.id_rental = r.id_rental
JOIN user_pelanggan u ON r.iduser = u.iduser   
JOIN mobil m ON r.platnomor = m.platnomor;  

SELECT * FROM view_transaksi_keseluruhan;
