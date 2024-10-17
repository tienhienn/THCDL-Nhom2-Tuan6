create database QUANLYGIAOHANG
go
use QUANLYGIAOHANG
create table KHACHHANG
(
	makhachhang char(10) primary key,
	tencongty nvarchar(100),
	tengiaodich nvarchar(50),
	diachi nvarchar(100),
	email varchar(50) unique not null
		check(email like '[a-z]%@%_'),
	dienthoai varchar(11) unique not null
		check(dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			or dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	fax varchar(11) unique
)
create table NHANVIEN
(
	manhanvien char(10) primary key,
	ho nvarchar(10),
	ten nvarchar(10),
	ngaysinh date,
	ngaylamviec date,
	diachi nvarchar(100),
	dienthoai varchar(11) unique not null
		check(dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			or dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	luongcoban decimal(18,0),
	phucap decimal (18,0)
)
create table DONDATHANG
(
	sohoadon char(10) primary key,
	makhachhang char(10),
	manhanvien char(10),
	ngaydathang date,
	ngaygiaohang date,
	ngaychuyenhang date,
	noigiaohang nvarchar(100),
	foreign key(makhachhang) references KHACHHANG(makhachhang)
		on update 
			cascade
		on delete 
			cascade,
	foreign key(manhanvien) references NHANVIEN(manhanvien)
		on update 
			cascade
		on delete 
			cascade
)
create table NHACUNGCAP
(
	macongty char(10) primary key,
	tencongty nvarchar(100),
	tengiaodich nvarchar(100),
	dienthoai varchar(11) unique not null
		check(dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
			or dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	fax varchar(11) unique,
	email varchar(50) unique not null
		check(email like '[a-z]%@%_'),
)
create table LOAIHANG
(
	maloaihang char(10) primary key,
	tenloaihang nvarchar(50),
)
create table MATHANG
(
	mahang char(10) primary key,
	tenhang nvarchar(100),
	macongty char(10),
	maloaihang char(10),
	soluong int,
	donvitinh nvarchar,
	giahang decimal(18,0),
    foreign key (maloaihang) references LOAIHANG(maloaihang)
		on update 
			cascade
		on delete 
			cascade,
    foreign key (macongty) references NHACUNGCAP(macongty)
		on update 
			cascade
		on delete 
			cascade
)
create table CHITIETDONHANG
(
	sohoadon char(10),
	mahang char(10),
	giaban decimal(18,0),
	soluong int,
	mucgiamgia decimal(5,2), 
	primary key(sohoadon,mahang),
	foreign key (sohoadon) references DONDATHANG(sohoadon)
		on update 
			cascade
		on delete 
			cascade,
	foreign key (mahang) references MATHANG(mahang)
		on update 
			cascade
		on delete 
			cascade
)
go
alter table CHITIETDONHANG
	add constraint DF_ChiTietDonHang_Soluong
			default 1 for soluong,
		constraint DF_ChiTietDonHang_MucGiamGia
			default 0 for mucgiamgia
alter table DONDATHANG
	add constraint CK_DonDatHang_ngayGiaoHang
			check(ngaygiaohang >= ngaydathang AND ngaygiaohang <= getdate()),
		constraint CK_DonDatHang_ngayChuyenHang
			check(ngaychuyenhang >= ngaydathang AND ngaychuyenhang <= getdate())
alter table NHANVIEN
	add constraint CK_NhanVien_ngayLamViec
			check (ngaylamviec >= dateadd(year,18,ngaysinh) 
				AND ngaylamviec <= dateadd(year,60,ngaysinh) 
				AND ngaylamviec<=getdate()),
		constraint CK_NhanVien_ngaySinh
			check (ngaysinh < getdate())