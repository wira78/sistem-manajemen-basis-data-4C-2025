-- 1 --
DELIMITER //
CREATE PROCEDURE GetTglRental()
BEGIN
SELECT * FROM rental
WHERE tgl_rental < DATE(NOW() - INTERVAL 3 MONTH);
	
END //
DELIMITER ;
CALL GetTglRental();

-- 2 --
DELIMITER //
CREATE PROCEDURE DeleteDataAfterAYear()
BEGIN

DELETE FROM transaksi
WHERE tgl_bayar <= CURDATE() - INTERVAL 1 YEAR
AND status_pembayaran = 'Lunas';
SELECT * FROM transaksi;
END//
DELIMITER ;

CALL DeleteDataAfterAYear();

-- 3 --
DELIMITER //

CREATE PROCEDURE UpdateTransactionStatus()
BEGIN
    UPDATE transaksi
    SET status_pembayaran = 'Sukses'
    WHERE status_pembayaran = 'Lunas'
    AND (SELECT COUNT(*) FROM transaksi WHERE status_pembayaran = 'Lunas') >= 7;

    SELECT * FROM transaksi;
END //
DELIMITER ;
CALL UpdateTransactionStatus();

-- 4 --
DELIMITER//
CREATE PROCEDURE EditUser(IN p_iduser INT, IN p_nama VARCHAR(45), IN p_alamat TEXT, IN p_email VARCHAR(45))
BEGIN
    UPDATE user_pelanggan
    SET nama = p_nama, alamat = p_alamat, email = p_email
    WHERE iduser = p_iduser
    AND NOT EXISTS (
        SELECT 1 FROM transaksi WHERE id_rental IN (
            SELECT id_rental FROM rental WHERE iduser = p_iduser
        )
    );
END //
DELIMITER ;
CALL EditUser(2, 'wira', 'sumenep', 'wira@gmail');
SELECT * FROM user_pelanggan WHERE iduser = 2;

-- 5 --
DELIMITER //

CREATE PROCEDURE UpdateTransactionStatusByMonth()
BEGIN
    DECLARE minAmount FLOAT;
    DECLARE maxAmount FLOAT;

    -- Mengambil jumlah bayar terkecil dan terbesar dalam 1 bulan terakhir
    SELECT MIN(jumlah_bayar), MAX(jumlah_bayar) INTO minAmount, maxAmount
    FROM transaksi
    WHERE tgl_bayar >= CURDATE() - INTERVAL 1 MONTH;

    -- Update status transaksi
    UPDATE transaksi
    SET STATUS = 
        CASE 
            WHEN jumlah_bayar = minAmount THEN 'non-aktif'
            WHEN jumlah_bayar NOT IN (minAmount, maxAmount) THEN 'pasif'
            ELSE 'aktif'
        END
    WHERE tgl_bayar >= CURDATE() - INTERVAL 1 MONTH;
    
    -- Menampilkan hasil transaksi
    SELECT * FROM transaksi;

END //

DELIMITER ;
DROP PROCEDURE UpdateTransactionStatusByMonth;
CALL UpdateTransactionStatusByMonth();

-- 6 --
DELIMITER //

CREATE PROCEDURE CountSuccessfulTransactions()
BEGIN
    DECLARE jumlah_transaksi INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE total_transaksi INT;

    -- Menghitung total transaksi berhasil selama 1 bulan terakhir
    SELECT COUNT(*) INTO total_transaksi
    FROM transaksi 
    WHERE status_pembayaran = 'sukses' 
      AND tgl_bayar >= CURDATE() - INTERVAL 1 MONTH;

    -- Looping untuk menampilkan setiap transaksi berhasil
    WHILE i <= total_transaksi DO
        SET jumlah_transaksi = jumlah_transaksi + 1;
        SET i = i + 1;
    END WHILE;

    -- Menampilkan hasil
    SELECT CONCAT('Jumlah Transaksi Lunas dalam 1 bulan terakhir: ', jumlah_transaksi) AS info_transaksi;
END //

DELIMITER ;

DROP PROCEDURE CountSuccessfulTransactions;
CALL CountSuccessfulTransactions();
