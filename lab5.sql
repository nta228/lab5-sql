CREATE DATABASE QlIPhongBan
--phong ban
		IF OBJECT_ID('PhongBan') IS NOT NULL
		DROP TABLE PhongBan
		GO
		CREATE TABLE PhongBan
		(
		MaPB VARCHAR(7) NOT NULL,
		TenPB NVARCHAR(50) null
		CONSTRAINT PK_PhongBan PRIMARY KEY (MaPB)
		)
--Nhan Vien
		IF OBJECT_ID('NhanVien') IS NOT NULL
		DROP TABLE NhanVien
		GO
		CREATE TABLE NhanVien
		(
		MaNV VARCHAR(7) NOT NULL,
		TenNV NVARCHAR(50) NULL,
		NgaySinh DATETIME check (NgaySinh<GETDATE()) ,
		SOCMND CHAR(9) NOT NULL,
		GioiTinh char(1) check(GioiTinh='F' or GioiTinh='M'),
		DiaChi NVARCHAR(100) NULL,
		NgayVaoLam DateTime  check(NgayVaoLam<GETDATE()),
		MaPB VARCHAR(7) NOT NULL
		CONSTRAINT PK_NhanVien PRIMARY KEY (MaNV),
		CONSTRAINT FK_NhanVien_PhongBan FOREIGN KEY (MaPB) REFERENCES PhongBan
		)
--Luong DA
		IF OBJECT_ID('LuongDA') IS NOT NULL
		DROP TABLE LuongDA
		GO
		CREATE TABLE LuongDA
		(
		MaDA VARCHAR(8) NOT NULL,
		MaNV VARCHAR(7) NOT NULL,
		NgayNhan Datetime DEFAULT(getdate()),
		SoTien money check(SoTien>0)
		CONSTRAINT PK_LuongDA PRIMARY KEY(MaDA),
		CONSTRAINT FK_LuongDA_NhanVien FOREIGN KEY (MaNV) REFERENCES NHANVIEN
		)
--
		SELECT * FROM PhongBan
		INSERT INTO PhongBan VALUES ('PB01','IT')
		INSERT INTO PhongBan VALUES ('PB02','Marketing')
		INSERT INTO PhongBan VALUES ('PB03','Tai Vu')
		INSERT INTO PhongBan VALUES ('PB04','Bao Ve')
		INSERT INTO PhongBan VALUES ('PB05','Giam Doc')

--
		SELECT * FROM NhanVien
		INSERT INTO NhanVien VALUES('NV01',N'Phạm Tuấn tài','1998-2-5','0123655','M',N'Nam Định','2020-3-4','PB01')
		INSERT INTO NhanVien VALUES('NV02',N'Vũ Thái Quý','1997-2-5','0123355','F',N'Hà Nội','2020-3-4','PB02')
		INSERT INTO NhanVien VALUES('NV03',N'Trương Đình Luât','1997-4-5','0423355','F',N'Hà Nội','2020-3-4','PB03')
		INSERT INTO NhanVien VALUES('NV04',N'Nguyễn Tuân','1992-2-5','0123355','F',N'Hà Nam','2020-3-4','PB04')
		INSERT INTO NhanVien VALUES('NV05',N'Vũ Luân','1997-2-8','0123354','F',N'Hà Nội','2020-3-4','PB05')
--
		SELECT * FROM LuongDA
		INSERT INTO LuongDA VALUES('DA01','NV02','2020-8-3',10000)
		INSERT INTO LuongDA VALUES('DA02','NV01','2020-8-3',100004)
		INSERT INTO LuongDA VALUES('DA03','NV04','2020-8-3',50000)
		INSERT INTO LuongDA VALUES('DA04','NV03','2020-8-3',20000)
		INSERT INTO LuongDA VALUES('DA05','NV05','2020-8-3',60000)
		--2
		SELECT * FROM PhongBan
		SELECT * FROM NhanVien
		SELECT * FROM LuongDA
		--3
		SELECT * FROM NhanVien
		WHERE GioiTinh='F'
		--4
		SELECT MaDA AS'Full DA' from luongDA;
		--5
		SELECT MaNV, SUM(SoTien) FROM luongDA GROUP BY MaNV;
		--6
		SELECT * FROM nhanvien WHERE MaPB='PB01';
		--7
		CREATE VIEW nhanvienhanhchinh AS
		SELECT MaNV, TenNV, NgaySinh, SOCMND, GioiTinh, DiaChi, NgayVaoLam, MaPB FROM  NhanVien 
		WHERE MaPB='PB01' WITH CHECK OPTION;
		Select * from nhanvienhanhchinh
		--
		CREATE VIEW Luongnhanvienhanhchinh AS
		SELECT  TenNV, SoTien, GioiTinh
		FROM nhanvienhanhchinh INNER JOIN luongDA
		ON nhanvienhanhchinh.MaNV = luongDA.MaNV;
		Select * from Luongnhanvienhanhchinh
		--8
		--9
		SELECT * FROM luongDA WHERE MaDA!='';
		--10
		SELECT MAX(MaPB) as NVMAX FROM phongban;
		--11
		SELECT COUNT(*) AS N' Tổng số nhân viên' FROM nhanvienhanhchinh ;
		--12
		SELECT right(SoCMND, 1), SoCMND
		FROM nhanvien
		WHERE right(SoCMND, 1) = '9'

		SELECT * FROM nhanvien nv, luongDA lgda
		WHERE RIGHT(nv.SoCMND, 1) = '9'  and nv.MaNV = lgda.MaNV
		--13
		SELECT MAX(SoTien) as GTLonNhat FROM luongDA;
		--14
		SELECT * FROM luongnhanvienhanhchinh
		WHERE (GioiTinh='F') AND (SoTien >1200000);
		--15
		SELECT pb.MaPB, pb.TenPB, summoney FROM phongban pb,(
		SELECT MaPB, SUM(SoTien) AS summoney FROM nhanvien AS nv, luongDA AS luong WHERE nv.MaNV = luong.MaNV 
		GROUP BY MaPB ) result WHERE pb.MaPB = result.MaPB;
		--16
		SELECT MaDA FROM luongDA
	    GROUP By MaDA
	    Having COUNT(MaNV) >= 2;
		
		--17
		SELECT right(MaNV, 1), MaNV
		FROM nhanvien
		WHERE right(MaNV, 1)='N';
		--18
		SELECT * FROM luongDA WHERE NgayNhan= '2020-8-3';
		--19
		SELECT * FROM luongDA WHERE MaDA='';
		--20
		DELETE FROM luongDA WHERE MaDA='DA02';
		--21
		DELETE FROM luongDA WHERE SoTien='100000';
		--22
		UPDATE luongDA
		SET SoTien = '100004'
		WHERE MaDA = 'DA02';
		SELECT * FROM luongDA;
		--23
		DELETE FROM NhanVien WHERE MaNV NOT IN (SELECT MaNV FROM LuongDa);
		--24
		UPDATE nhanvienhanhchinh
		SET NgayVaoLam = 12/02/1999;
		select * from nhanvienhanhchinh;
		   
