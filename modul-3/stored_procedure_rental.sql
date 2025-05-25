DELIMITER//
CREATE PROCEDURE UpdateDataMaster (
	IN id INT,
	IN harga FLOAT,
	IN warna_baru VARCHAR (45)
)
BEGIN 
	UPDATE mobil 
	SET harga_rental = harga ,
	warna = warna_baru
	WHERE platnomor = id;
END//
DELIMITER;

SET @harga = 420000;
SET @warna_baru = 'hijau';
CALL UpdateDataMaster(1010, @harga, @warna_baru);
SET @harga = 420000;
SET @warna_baru = 'hijau';
CALL update_isi_mobil(1010, @harga, @warna_baru);
SELECT platnomor,harga_rental,warna FROM mobil;

DELIMITER //

CREATE PROCEDURE CountTransaksi (
    OUT jumlah INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah FROM transaksi;
END //

DELIMITER ;
SET @jumlah = 0;
CALL CountTransaksi(@jumlah);
SELECT @jumlah AS total_transaksi;


DELIMITER //

CREATE PROCEDURE GetDataMasterByID (
    IN id INT,
    OUT nama_out VARCHAR(45),
    OUT alamat_out TEXT,
    OUT jk_out ENUM('P','L'),
    OUT hp_out VARCHAR(45),
    OUT ktp_out VARCHAR(45),
    OUT email_out VARCHAR(45)
)
BEGIN
    SELECT nama, alamat, jenis_kelamin, no_hp, no_ktp, email
    INTO nama_out, alamat_out, jk_out, hp_out, ktp_out, email_out
    FROM user_pelanggan WHERE iduser = id;
END //

DELIMITER ;
SET @nama = '', @alamat = '', @jk = '', @hp = '', @ktp = '', @email = '';
CALL GetDataMasterByID(1, @nama, @alamat, @jk, @hp, @ktp, @email);
SELECT 
  @nama AS nama,
  @alamat AS alamat,
  @jk AS jenis_kelamin,
  @hp AS no_hp,
  @ktp AS no_ktp,
  @email AS email;

DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
    IN id INT, INOUT f1 FLOAT, INOUT f2 VARCHAR(45)
)
BEGIN
    SELECT jumlah_bayar, metode_pembayaran INTO @a, @b FROM transaksi WHERE idtransaksi = id;
    SET f1 = IFNULL(f1, @a), f2 = IF(f2 = '' OR f2 IS NULL, @b, f2);
    UPDATE transaksi SET jumlah_bayar = f1, metode_pembayaran = f2 WHERE idtransaksi = id;
END //

DELIMITER ;
SET @jumlah_bayar = 180000, @metode = '';
CALL UpdateFieldTransaksi(1, @jumlah_bayar, @metode);
SELECT @jumlah_bayar AS jumlah_bayar_baru, @metode AS metode_pembayaran_baru;

DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster (IN id INT)
BEGIN
    DELETE FROM user_pelanggan WHERE iduser = id;
END //

DELIMITER ;
CALL DeleteEntriesByIDMaster(5);
SELECT * FROM user_pelanggan WHERE iduser = 5;

