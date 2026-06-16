-- create table -- 

CREATE TABLE paket (
    id_paket VARCHAR(10) PRIMARY KEY,
    pengirim VARCHAR(50),
    status VARCHAR(20),
    deskripsi TEXT,
    waktu_kedatangan DATETIME,
    nama_penerima VARCHAR(50),
    tag VARCHAR(20)
);

CREATE TABLE survey (
    id_survey VARCHAR(10) PRIMARY KEY,
    judul VARCHAR(100)
);

CREATE TABLE polling (
    id_polling VARCHAR(10) PRIMARY KEY,
    status VARCHAR(20),
    ta VARCHAR(20),
    kategori VARCHAR(20),
    sem_ta VARCHAR(20),
    id_survey VARCHAR(10),
    FOREIGN KEY (id_survey) REFERENCES survey(id_survey)
);

CREATE TABLE kuisioner (
    id_kuisioner VARCHAR(10) PRIMARY KEY,
    judul VARCHAR(100),
    status VARCHAR(20),
    kategori VARCHAR(20),
    tanggal_pembuatan VARCHAR(20),
    sem_ta VARCHAR(20)
);

CREATE TABLE kuisioner_sem_ta (
    id_kuisioner VARCHAR(10),
    sem_ta VARCHAR(20),
    PRIMARY KEY (id_kuisioner, sem_ta),
    FOREIGN KEY (id_kuisioner) REFERENCES kuisioner(id_kuisioner)
);

-- INSERT INTO --
INSERT INTO paket (id_paket, pengirim, status, deskripsi, waktu_kedatangan, nama_penerima, tag) VALUES 
('PKT001', 'JNE', 'Tiba', 'Dokumen Akademik', '2025-04-01 10:00:00', 'Arya', 'Penting'),
('PKT002', 'POS Indonesia', 'Diambil', 'Sertifikat Lomba', '2025-04-03 14:00:00', 'Indah', 'Lomba'),
('PKT003', 'Tokopedia', 'Tiba', 'Alat Praktikum', '2025-04-05 11:00:00', 'Josef', 'Lab');
select* from paket

INSERT INTO survey (id_survey, judul) VALUES 
('S001', 'Evaluasi Dosen Semester Genap'),
('S002', 'Kepuasan layanan IT'),
('S003', 'Umpan Balik Mahasiswa');
select* from survey

INSERT INTO polling (id_polling, status, ta, kategori, sem_ta, id_survey) VALUES 
('PL001', 'Aktif', '2024/2025', 'Umum', 'Genap', 'S001'),
('PL002', 'Selesai', '2024/2025', 'IT', 'Ganjil', 'S002');
select* from polling

INSERT INTO kuisioner (id_kuisioner, judul, status, kategori, tanggal_pembuatan) VALUES 
('K001', 'Survey Sarana & Prasarana', 'Aktif', 'Umum', '2024/2025'),
('K002', 'Kinerja Dosen', 'Selesai', 'Akademik', '2023/2024');

INSERT INTO kuisioner_sem_ta (id_kuisioner, sem_ta) VALUES 
('K001', 'Genap'),
('K002', 'Ganjil');
select* from kuisioner
select* from kuisioner_sem_ta

-- select, from, whwere

-- Select all packages with status 'Tiba'
SELECT * FROM paket WHERE status = 'Tiba';

-- Select packages with tag 'Lab'
SELECT * FROM paket WHERE tag = 'Lab';

-- Select all surveys
SELECT * FROM survey;

-- Select survey with specific ID
SELECT * FROM survey WHERE id_survey = 'S001';

-- Select active pollings
SELECT * FROM polling WHERE status = 'Aktif';

-- Select pollings for academic year 2024/2025
SELECT * FROM polling WHERE ta = '2024/2025';

-- Select active kuisioners
SELECT * FROM kuisioner WHERE status = 'Aktif';

-- Select kuisioners with specific category
SELECT * FROM kuisioner WHERE kategori = 'Akademik';

-- update data --

-- Update status of package PKT002
UPDATE paket SET status = 'Tiba' WHERE id_paket = 'PKT002';
-- Update tag of package PKT003
UPDATE paket SET tag = 'Praktikum' WHERE id_paket = 'PKT003';
SELECT * FROM paket 

-- Update survey title
UPDATE survey SET judul = 'Evaluasi Dosen Genap 2025' WHERE id_survey = 'S001';
SELECT * FROM survey

-- Update polling status
UPDATE polling SET status = 'Selesai' WHERE id_polling = 'PL001';
SELECT * FROM polling
-- Update polling category
UPDATE polling SET kategori = 'Akademik' WHERE id_polling = 'PL002';
SELECT * FROM polling

-- Update kuisioner status
UPDATE kuisioner SET status = 'Selesai' WHERE id_kuisioner = 'K001';
SELECT * FROM kuisioner
-- Update kuisioner semester
UPDATE kuisioner_sem_ta SET sem_ta = 'Ganjil' WHERE id_kuisioner = 'K001';
SELECT * FROM kuisioner_sem_ta


-- Set Operation --
-- Union of packages with status 'Tiba' and tag 'Penting'
SELECT id_paket, nama_penerima FROM paket WHERE status = 'Tiba'
UNION
SELECT id_paket, nama_penerima FROM paket WHERE tag = 'Penting';


SELECT p1.id_paket, p1.nama_penerima 
FROM paket p1
INNER JOIN paket p2 ON p1.id_paket = p2.id_paket 
WHERE p1.status = 'Tiba' AND p2.tag = 'Penting';

-- Union with polling table (assuming similar structure)
SELECT id_survey, judul FROM survey
UNION
SELECT id_polling, kategori FROM polling;


-- Union with kuisioner table
SELECT id_polling as id, status, sem_ta FROM polling
UNION
SELECT id_kuisioner as id, status, sem_ta FROM kuisioner;

-- Union with polling table
SELECT id_kuisioner as id, judul, status FROM kuisioner
UNION
SELECT id_polling as id, sem_ta, status FROM polling;
select* from kuisioner
select* from polling

-- Aggregate Function --

-- Count packages by status
SELECT status, COUNT(*) as total_paket 
FROM paket 
GROUP BY status;
-- Average length of description by tag
SELECT tag, AVG(LEN(CAST(deskripsi AS VARCHAR(MAX)))) as avg_desc_length 
FROM paket
GROUP BY tag;

-- Count total surveys
SELECT COUNT(*) as total_surveys FROM survey;
-- Average length of survey titles
SELECT AVG(LEN(judul)) as avg_title_length FROM survey;

-- Count pollings by status
SELECT status, COUNT(*) as total_polling 
FROM polling 
GROUP BY status;
-- Count pollings by category
SELECT kategori, COUNT(*) as total_polling 
FROM polling 
GROUP BY kategori;

-- Count kuisioners by status
SELECT status, COUNT(*) as total_kuisioner 
FROM kuisioner 
GROUP BY status;

-- Count kuisioners by category
SELECT kategori, COUNT(*) as total_kuisioner 
FROM kuisioner 
GROUP BY kategori;

-- null value -- 
-- Insert a package with NULL tag
INSERT INTO paket (id_paket, pengirim, status, deskripsi, waktu_kedatangan, nama_penerima, tag) 
VALUES ('PKT004', 'J&T', 'Proses', 'Buku Referensi', '2025-04-07 09:00:00', 'Arion', NULL);
-- Select packages with NULL tag
SELECT * FROM paket WHERE tag IS NULL;

-- Insert a package with NULL tag
INSERT INTO paket (id_paket, pengirim, status, deskripsi, waktu_kedatangan, nama_penerima, tag) 
VALUES ('PKT005', 'Lion Parcel', 'tiba', 'Meja Belajar', '2025-04-07 15:00:00', 'Arion', NULL);
-- Select packages with NULL tag
SELECT * FROM paket WHERE tag IS NULL;
SELECT * FROM paket WHERE tag IS NULL;

-- Insert survey with NULL title (not recommended, just for demonstration)
INSERT INTO survey (id_survey, judul) VALUES ('S004', NULL);
-- Select surveys with NULL titles
SELECT * FROM survey WHERE judul IS NULL;

-- Insert polling with NULL survey ID
INSERT INTO polling (id_polling, status, ta, kategori, sem_ta, id_survey) 
VALUES ('PL003', 'Aktif', '2024/2025', 'Umum', 'Genap', NULL);
-- Select pollings with NULL survey ID
SELECT * FROM polling WHERE id_survey IS NULL;

-- Insert kuisioner with NULL category
INSERT INTO kuisioner (id_kuisioner, judul, status, kategori, tanggal_pembuatan) 
VALUES ('K003', 'Evaluasi Fasilitas', 'Aktif', NULL, '2024/2025');
-- Select kuisioners with NULL category
SELECT *
FROM kuisioner WHERE kategori IS NULL;

-------------------------------------------------------------------------------
-------------------------------- Query Multiple ----------------------------------
------------------------------------------------------------------------------------

-- Inner Join with pengumuman (assuming both have pengirim/nama_penerima fields)
SELECT p.id_paket, p.status, pl.id_polling, pl.status AS polling_status
FROM paket p
INNER JOIN polling pl ON p.status = pl.status;
-- Left Join
SELECT p.id_paket, p.tag, k.id_kuisioner, k.kategori
FROM paket p
LEFT JOIN kuisioner k ON p.tag = k.kategori;
-- Cross Join
SELECT p.id_paket, k.id_kuisioner, k.judul
FROM paket p
CROSS JOIN kuisioner k;

-- Inner Join with polling
SELECT s.id_survey, s.judul, pl.id_polling, pl.status
FROM survey s
INNER JOIN polling pl ON s.id_survey = pl.id_survey;
-- Left Join
SELECT s.id_survey, s.judul, pl.id_polling, pl.status
FROM survey s
LEFT JOIN polling pl ON s.id_survey = pl.id_survey;

-- Inner Join with survey
SELECT pl.id_polling, pl.sem_ta, ks.id_kuisioner
FROM polling pl
INNER JOIN kuisioner_sem_ta ks ON pl.sem_ta = ks.sem_ta;
-- Left Join
SELECT pl.id_polling, pl.status, s.judul AS survey_judul
FROM polling pl
LEFT JOIN survey s ON pl.id_survey = s.id_survey;

-- Inner Join with semester table
SELECT k.id_kuisioner, k.judul, ks.sem_ta
FROM kuisioner k
INNER JOIN kuisioner_sem_ta ks ON k.id_kuisioner = ks.id_kuisioner;

--Inner Join kuisioner_sem_ta with kuisioner
SELECT ks.id_kuisioner, ks.sem_ta, k.judul
FROM kuisioner_sem_ta ks
INNER JOIN kuisioner k ON ks.id_kuisioner = k.id_kuisioner;

-- Left Join
SELECT k.id_kuisioner, k.kategori, p.id_paket, p.tag
FROM kuisioner k
LEFT JOIN paket p ON k.kategori = p.tag;

---------------------------------------------------------------
------------------------------- Implementing Views  --------------

--Nested Subquery View

CREATE VIEW view_paket_tiba AS
SELECT* FROM paket 
WHERE id_paket IN (SELECT id_paket FROM paket WHERE status = 'Tiba');
SELECT* FROM view_paket_tiba;

--Inner Join View
CREATE VIEW view_paket_inner_polling AS
SELECT p.id_paket, p.nama_penerima, pl.status AS polling_status
FROM paket p
INNER JOIN polling pl ON p.status = pl.status;
SELECT* FROM view_paket_inner_polling;

--Left Join View
CREATE VIEW view_paket_left_polling AS
SELECT p.id_paket, p.nama_penerima, pl.status AS polling_status
FROM paket p
LEFT JOIN polling pl ON p.status = pl.status;
SELECT* FROM view_paket_left_polling;


--Cross Join View 
CREATE VIEW view_paket_cross_kuisioner AS
SELECT p.id_paket, k.id_kuisioner
FROM paket p
CROSS JOIN kuisioner k;
SELECT* FROM view_paket_cross_kuisioner;

---- survey ------

-- Nested Subquery View
CREATE VIEW view_survey_with_active_polling AS
SELECT * 
FROM survey
WHERE id_survey IN (
    SELECT id_survey FROM polling WHERE status = 'Aktif'
);
SELECT* FROM view_survey_with_active_polling;

--Inner Join View
CREATE VIEW view_survey_inner_polling AS
SELECT s.id_survey, s.judul, p.id_polling, p.status
FROM survey s
INNER JOIN polling p ON s.id_survey = p.id_survey;
SELECT* FROM view_survey_inner_polling;

--Left Join View
CREATE VIEW view_survey_left_polling AS
SELECT s.id_survey, s.judul, p.id_polling, p.status
FROM survey s
LEFT JOIN polling p ON s.id_survey = p.id_survey;
SELECT* FROM view_survey_left_polling;

--Cross Join View
CREATE VIEW view_survey_cross_paket AS
SELECT s.id_survey, p.id_paket
FROM survey s
CROSS JOIN paket p;
SELECT* FROM view_survey_cross_paket;

---------------- polling -------------------------
--Nested Subquery View
CREATE VIEW view_polling_survey_check AS
SELECT * 
FROM polling 
WHERE id_survey IN (SELECT id_survey FROM survey WHERE judul LIKE '%Evaluasi%');
SELECT* FROM view_polling_survey_check;

--Inner Join View
CREATE VIEW view_polling_inner_kuisioner AS
SELECT p.id_polling, k.id_kuisioner, k.judul
FROM polling p
INNER JOIN kuisioner k ON p.sem_ta = k.sem_ta;
SELECT* FROM view_polling_inner_kuisioner;

--Left Join View
CREATE VIEW view_polling_left_kuisioner AS
SELECT p.id_polling, k.id_kuisioner, k.judul
FROM polling p
LEFT JOIN kuisioner k ON p.sem_ta = k.sem_ta;
SELECT* FROM view_polling_left_kuisioner;

--Cross Join View
CREATE VIEW view_polling_cross_kuisioner AS
SELECT p.id_polling, k.id_kuisioner
FROM polling p
CROSS JOIN kuisioner k;
SELECT* FROM view_polling_cross_kuisioner;

--kuisioner
--Nested Subquery View
CREATE VIEW view_kuisioner_active_semester AS
SELECT * 
FROM kuisioner 
WHERE id_kuisioner IN (
    SELECT id_kuisioner FROM kuisioner_sem_ta WHERE sem_ta = 'Genap');
SELECT* FROM view_kuisioner_active_semester;


--Inner Join View
CREATE VIEW view_kuisioner_inner_kuisioner_sem AS
SELECT k.id_kuisioner, k.judul, ks.sem_ta
FROM kuisioner k
INNER JOIN kuisioner_sem_ta ks ON k.id_kuisioner = ks.id_kuisioner;
SELECT* FROM view_kuisioner_inner_kuisioner_sem;


--Left Join View
CREATE VIEW view_kuisioner_left_kuisioner_sem AS
SELECT k.id_kuisioner, k.judul, ks.sem_ta
FROM kuisioner k
LEFT JOIN kuisioner_sem_ta ks ON k.id_kuisioner = ks.id_kuisioner;
SELECT* FROM view_kuisioner_left_kuisioner_sem;


--Cross Join View
CREATE VIEW view_kuisioner_cross_survey AS
SELECT k.id_kuisioner, s.id_survey
FROM kuisioner k
CROSS JOIN survey s;
SELECT* FROM view_kuisioner_cross_survey;

---------------------- Function and store Procedcure ---------------------------------
-----------------------------------------------------------------

-- 1. paket
-- Function
-- FUNCTION
CREATE FUNCTION fn_jumlah_paket_by_status (@status VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @jumlah INT
    SELECT @jumlah = COUNT(*) FROM paket WHERE status = @status
    RETURN @jumlah
END;
GO

-- MENAMPILKAN HASIL FUNCTION
SELECT dbo.fn_jumlah_paket_by_status('Diterima') AS JumlahPaketDiterima;


--Stored Procedure: Menambahkan data paket baru
-- DROP PROCEDURE (pindahkan ke atas kalau belum dilakukan)
DROP PROCEDURE IF EXISTS sp_tambah_paket_nullable;
GO

CREATE PROCEDURE sp_tambah_paket_nullable
    @id_paket VARCHAR(10),
    @pengirim VARCHAR(50),
    @status VARCHAR(20),
    @deskripsi TEXT,
    @waktu_kedatangan DATETIME,
    @nama_penerima VARCHAR(50),
    @tag VARCHAR(20) = NULL -- Default NULL jika tidak diisi
AS
BEGIN
    INSERT INTO paket (
        id_paket,
        pengirim,
        status,
        deskripsi,
        waktu_kedatangan,
        nama_penerima,
        tag
    )
    VALUES (
        @id_paket,
        @pengirim,
        @status,
        @deskripsi,
        @waktu_kedatangan,
        @nama_penerima,
        @tag
    );
END;
GO

-- EKSEKUSI TANPA KURUNG
-- Jalankan stored procedure
-- Correct way to execute the stored procedure
EXEC sp_tambah_paket 
    @id_paket = 'P001', 
    @pengirim = 'PT Pos', 
    @status = 'Diterima', 
    @deskripsi = 'Dokumen penting', 
    @waktu_kedatangan = GETDATE(), 
    @nama_penerima = 'Andi', 
    @tag = 'dokumen';

-- Tampilkan data yang baru ditambahkan
SELECT * FROM paket WHERE id_paket = 'P001';
-- Option 1: Results will be automatically displayed from the procedure
-- Option 2: Query the table directly
SELECT * FROM paket WHERE id_paket = 'P001';

--- Survey
--- Function
-- FUNCTION
CREATE FUNCTION fn_judul_survey (@id VARCHAR(10))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @judul VARCHAR(100)
    SELECT @judul = judul FROM survey WHERE id_survey = @id
    RETURN @judul
END;
GO

-- MENAMPILKAN HASIL FUNCTION
SELECT dbo.fn_judul_survey('S001') AS JudulSurvey;


---Stored Procedure: Update judul survey
-- STORED PROCEDURE
CREATE PROCEDURE sp_update_judul_survey
    @id VARCHAR(10),
    @judul_baru VARCHAR(100)
AS
BEGIN
    UPDATE survey SET judul = @judul_baru WHERE id_survey = @id
END;
GO

-- MENJALANKAN STORED PROCEDURE
EXEC sp_update_judul_survey 'S001', 'Survey Kepuasan Mahasiswa';
SELECT OBJECT_DEFINITION(OBJECT_ID('sp_update_judul_survey'));

---. POLLING
-- Function: Hitung polling berdasarkan status
-- FUNCTION
CREATE FUNCTION fn_jumlah_polling_by_status (@status VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @jumlah INT
    SELECT @jumlah = COUNT(*) FROM polling WHERE status = @status
    RETURN @jumlah
END;
GO

-- MENAMPILKAN HASIL FUNCTION
SELECT dbo.fn_jumlah_polling_by_status('Aktif') AS JumlahPollingAktif;

---Stored Procedure: Tambah polling baru
-- STORED PROCEDURE
CREATE PROCEDURE sp_tambah_polling
    @id_polling VARCHAR(10),
    @status VARCHAR(20),
    @ta VARCHAR(20),
    @kategori VARCHAR(20),
    @sem_ta VARCHAR(20),
    @id_survey VARCHAR(10)
AS
BEGIN
    INSERT INTO polling VALUES (@id_polling, @status, @ta, @kategori, @sem_ta, @id_survey)
END;
GO

-- MENJALANKAN STORED PROCEDURE
EXEC sp_tambah_polling 'PL001', 'Aktif', '2024/2025', 'Akademik', 'Genap', 'S001';
SELECT OBJECT_DEFINITION(OBJECT_ID('sp_tambah_polling'));


---KUISIONER
--Function
-- FUNCTION
CREATE FUNCTION fn_status_kuisioner (@id VARCHAR(10))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @status VARCHAR(20)
    SELECT @status = status FROM kuisioner WHERE id_kuisioner = @id
    RETURN @status
END;
GO

-- MENAMPILKAN HASIL FUNCTION
SELECT dbo.fn_status_kuisioner('K001') AS StatusKuisioner;

--Stored Procedure: Update kategori kuisioner

-- STORED PROCEDURE
CREATE PROCEDURE sp_update_kategori_kuisioner
    @id VARCHAR(10),
    @kategori_baru VARCHAR(20)
AS
BEGIN
    UPDATE kuisioner SET kategori = @kategori_baru WHERE id_kuisioner = @id
END;
GO

-- MENJALANKAN STORED PROCEDURE
EXEC sp_update_kategori_kuisioner 'K001', 'Administrasi';
SELECT OBJECT_DEFINITION(OBJECT_ID('sp_update_kategori_kuisioner'));

-- KUISIONER_SEM_TA
--Function: Ambil semester berdasarkan ID kuisioner
-- FUNCTION
CREATE FUNCTION fn_semester_kuisioner (@id VARCHAR(10))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @sem_ta VARCHAR(20)
    SELECT @sem_ta = sem_ta FROM kuisioner_sem_ta WHERE id_kuisioner = @id
    RETURN @sem_ta
END;
GO

-- MENAMPILKAN HASIL FUNCTION
SELECT dbo.fn_semester_kuisioner('K001') AS SemesterKuisioner;


--Stored Procedure: Tambahkan semester untuk kuisioner
-- STORED PROCEDURE
CREATE PROCEDURE sp_tambah_semester_kuisioner
    @id_kuisioner VARCHAR(10),
    @sem_ta VARCHAR(20)
AS
BEGIN
    INSERT INTO kuisioner_sem_ta VALUES (@id_kuisioner, @sem_ta)
END;
GO

-- MENJALANKAN STORED PROCEDURE
-- Execute the stored procedure
EXEC sp_tambah_semester_kuisioner 'K001', 'Genap 2024/2025';

-- Display the results by querying the table
SELECT * FROM kuisioner_sem_ta 
WHERE id_kuisioner = 'K001' AND sem_ta = 'Genap 2024/2025';