create database QLHD
go
use QLHD
create table KHACHHANG
(
	MAKHACHHANG char(10) primary key,
	TENCONGTY  nvarchar(50),
	TENGIAODICH nvarchar(50),
	DIACHI nvarchar(50),
	EMAIL varchar(30),
	DIENTHOAI varchar(11),
	FAX varchar(30)
	unique (FAX,DIENTHOAI,EMAIL)
)
create table NHANVIEN
(
	MANHANVIEN char(10) primary key,
	HO nvarchar(10),
	TEN nvarchar(10),
	NGAYSINH date,
	NGAYLAMVIEC date,
	DIACHI nvarchar(50),
	DIENTHOAI varchar(11) unique,
	LUONGCOBAN money,
	PHUCAP money
)
create table DONDATHANG
(
	SOHOADON char(10) primary key,
	MAKHACHHANG char(10),
	MANHANVIEN char(10),
	NGAYDATHANG date,
	NGAYGIAOHANG date,
	NGAYCHUYENHANG date,
	NOIGIAOHANG nvarchar(30)
	foreign key (MANHANVIEN) references NHANVIEN(MANHANVIEN),
	foreign key (MAKHACHHANG) references KHACHHANG(MAKHACHHANG)
)
create table NHACUNGCAP
(
	MACONGTY char(10) primary key,
	TENCONGTY nvarchar(30),
	TENGIAODICH nvarchar(30),
	DIACHI nvarchar(50),
	EMAIL varchar(30),
	DIENTHOAI varchar(11),
	FAX varchar(30)
	unique (FAX,DIENTHOAI,EMAIL)
)
create table LOAIHANG
(
	MALOAIHANG char(10) primary key,
	TENLOAIHANG nvarchar(30)
)
create table MAHANG
(
	MAHANG char(10) primary key,
	TENHANG nvarchar(30),
	MACONGTY char(10),
	MALOAIHANG char(10),
	SOLUONG int,
	DONVITINH money,
	GIAHANG money
	foreign key (MACONGTY) references NHACUNGCAP(MACONGTY),
	foreign key (MALOAIHANG) references LOAIHANG(MALOAIHANG)
)
create table CHITIETDATHANG
(
	SOHOADON char(10),
	MAHANG char(10),
	GIABAN money,
	SOLUONG int,
	MUCGIAMGIA decimal
	primary key (SOHOADON, MAHANG),
	foreign key (SOHOADON) references DONDATHANG(SOHOADON),
	foreign key (MAHANG) references MAHANG(MAHANG)
)
alter table CHITIETDATHANG
	add constraint soluong_default default '1' for soluong,
		constraint mucgiamgia_default default '0' for mucgiamgia
alter table DONDATHANG
	add constraint ngaygiaohang_check check (ngaygiaohang >= ngaydathang),
		constraint ngaychuyenhang_check check (ngaychuyenhang >= ngaydathang)
alter table NHANVIEN
	add constraint CHECK_AGE check(DATEDIFF(YEAR, NGAYSINH, GETDATE()) >= 18 
								AND DATEDIFF(YEAR, NGAYSINH, GETDATE()) <= 60)
