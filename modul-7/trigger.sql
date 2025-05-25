DELIMITER //
CREATE TRIGGER before_transaksi_insert
BEFORE INSERT ON transaksi 
FOR EACH ROW
BEGIN
    DECLARE rental_exists INT;
    SELECT COUNT(*) INTO rental_exists FROM rental WHERE id_rental = NEW.id_rental;
    IF rental_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ID Rental tidak valid atau belum terdaftar.';
    END IF;
END;
DELIMITER;

DELIMITER//
CREATE TRIGGER before_rental_update
BEFORE UPDATE ON rental 
FOR EACH ROW
BEGIN
    IF NEW.tgl_kembali < NEW.tgl_rental THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tanggal kembali tidak boleh lebih awal dari tanggal rental.';
    END IF;
END;
DELIMITER;

DELIMITER//
CREATE TRIGGER before_delete_transaksi
BEFORE DELETE ON transaksi
FOR EACH ROW
BEGIN
    IF OLD.status_pembayaran = 'Belum Lunas' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak bisa menghapus transaksi dengan status "Belum Lunas"!';
    END IF;
END;
DELIMITER;

DELIMITER //
CREATE TRIGGER after_insert_transaksi
AFTER INSERT ON transaksi
FOR EACH ROW
BEGIN
    INSERT INTO denda (id_rental, tgl_denda, jumlah_denda, keterangan)
    VALUES (NEW.id_rental, NOW(), 0, 'Pengecekan awal setelah transaksi baru');
END;
DELIMITER;

DELIMITER //
CREATE TRIGGER after_update_rental
AFTER UPDATE ON rental
FOR EACH ROW
BEGIN
    IF NEW.tgl_pengembalian > NEW.tgl_kembali THEN
        UPDATE denda
        SET jumlah_denda = 50000, keterangan = 'Pengembalian terlambat'
        WHERE id_rental = NEW.id_rental;
    END IF;
END //
DELIMITER ;

CREATE TABLE log_aktivitas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    aksi VARCHAR(20),
    tgl_aksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    detail TEXT
);

DELIMITER //
CREATE TRIGGER after_delete_mobil
AFTER DELETE ON mobil
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (aksi, tgl_aksi, detail)
    VALUES ('DELETE', NOW(), CONCAT('Mobil dengan plat nomor ', OLD.platnomor, ' telah dihapus.'));
END //
DELIMITER ;
DELETE FROM mobil WHERE platnomor = 101;
SELECT * FROM log_aktivitas WHERE aksi = 'DELETE';
