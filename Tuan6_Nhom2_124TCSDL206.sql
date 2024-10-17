create database Quanlycongtacgiaohang
go
use Quanlycongtacgiaohang
create table Khachhang
(
	Makhachhang char(10) primary key,
	Tencongty nvarchar(50),
	Tengiaodich nvarchar(50),
	Diachi nvarchar(50),
	Email varchar(30) unique,
	Dienthoai varchar(11) unique,
	Fax varchar(30) unique,
)
create table Nhanvien
(
	Manhanvien char(10) Primary key,
	Ho nvarchar(10),
	Ten nvarchar(10),
	Ngaysinh date,
	Ngaylamviec date,
	Diachi nvarchar(50),
	Dienthoai varchar(11) unique,
	Luongcoban money,
	Phucap money
)
create table Dondathang
(
	Sohoadon char(10) Primary key,
	Makhachhang char(10) foreign key (makhachhang) references Khachhang(Makhachhang)
		on update 
			cascade
		on delete 
			cascade,
	manhanvien char(10) foreign key (Manhanvien) references Nhanvien(Manhanvien)
		on update 
			cascade
		on delete 
			cascade,
	Ngaydathang date,
	Ngaygiaohang date,
	Ngaychuyenhang date,
	Noigiaohang nvarchar(50)
)
create table Loaihang
(
	Maloaihang char(10) primary key,
	Tenloaihang nvarchar(50)
)
create table Nhacungcap
(
	Macongty char(10) Primary key,
	Tencongty nvarchar(50),
	Tengiaodich nvarchar(50),
	Diachi nvarchar(50),
	Dienthoai varchar(11) unique,
	Fax varchar(30) unique,
	Email varchar(30) unique
)
create table Mahang
(
	Mahang char(10) primary key,
	Tenhang nvarchar(50),
	Macongty char(10) foreign key (Macongty) references Nhacungcap(Macongty)
		on update 
			cascade
		on delete 
			cascade,
	Maloaihang char(10) foreign key (Maloaihang) references Loaihang(Maloaihang)
		on update 
			cascade
		on delete 
			cascade,
	Soluong int,
	Donvitinh money,
	Giahang money
)
create table Chitietdathang
(
	Sohoadon char(10) ,
	Mahang char(10) ,
	Giaban money,
	Soluong int,
	Mucgiamgia decimal
	primary key (Sohoadon, Mahang),
	foreign key (Sohoadon) references Dondathang(Sohoadon)
		on update 
			cascade
		on delete 
			cascade,
	foreign key (Mahang) references Mahang(Mahang)
		on update 
			cascade
		on delete 
			cascade
)
go
--Ràng buộc
alter table Chitietdathanng
	add constraint DF_Chitietdathang_Soluong default 1 for Soluong,
		constraint DF_Chitietdathang_Mucgiamgia default 0 for Mucgiamgia
alter table Dondathang
	add constraint CK_Dondathang_Ngaygiaohang
			check(Ngaygiaohang >= Ngaydathang and Ngaygiaohang <= getdate()),
		constraint CK_Dondathang_Ngaychuyenhang
			check (Ngaychuyenhang >= Ngaydathang and Ngaychuyenhang <= getdate())
alter table Nhanvien
	add constraint CK_Nhanvien_Ngaylamviec
			check (Ngaylamviec >= dateadd(year,18,Ngaysinh)
				and Ngaylamviec	<= dateadd(year,60,Ngaysinh)
				and Ngaylamviec <= getdate()),
		constraint CK_Nhanvien_Ngaysinh
			check(Ngaysinh< getdate())
