-- =================================================================
-- SCRIPT TẠO DATABASE VÀ THÊM DỮ LIỆU MẪU PHONG PHÚ (SQL SERVER)
-- Họ tên: Lê Huỳnh Phong | MSSV: 24110302 | Mã đề 05
-- =================================================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'WebGiuaKyDB')
BEGIN
    ALTER DATABASE WebGiuaKyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE WebGiuaKyDB;
END
GO

CREATE DATABASE WebGiuaKyDB;
GO

USE WebGiuaKyDB;
GO

-- 1. Bảng UserRoles
CREATE TABLE UserRoles (
    roleId BIGINT IDENTITY(1,1) PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- 2. Bảng Seller
CREATE TABLE Seller (
    sellerId BIGINT IDENTITY(1,1) PRIMARY KEY,
    sellerName NVARCHAR(200) NOT NULL,
    images NVARCHAR(500),
    status INT DEFAULT 1
);
GO

-- 3. Bảng Users
CREATE TABLE Users (
    userId BIGINT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL UNIQUE,
    email NVARCHAR(150) NOT NULL UNIQUE,
    fullname NVARCHAR(150),
    password NVARCHAR(255) NOT NULL,
    images NVARCHAR(500),
    phone NVARCHAR(20),
    status INT DEFAULT 1,
    code NVARCHAR(50),
    roleId BIGINT FOREIGN KEY REFERENCES UserRoles(roleId),
    sellerId BIGINT FOREIGN KEY REFERENCES Seller(sellerId)
);
GO

-- 4. Bảng Category
CREATE TABLE Category (
    categoryId BIGINT IDENTITY(1,1) PRIMARY KEY,
    categoryName NVARCHAR(150) NOT NULL,
    images NVARCHAR(500),
    status INT DEFAULT 1
);
GO

-- 5. Bảng Product
CREATE TABLE Product (
    productId BIGINT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(200) NOT NULL,
    productCode NVARCHAR(50),
    categoryId BIGINT FOREIGN KEY REFERENCES Category(categoryId),
    description NVARCHAR(MAX),
    price DECIMAL(18, 2),
    amount INT DEFAULT 0,
    stock INT DEFAULT 0,
    images NVARCHAR(500),
    wishlist INT DEFAULT 0,
    status INT DEFAULT 1,
    createDate DATETIME DEFAULT GETDATE(),
    sellerId BIGINT FOREIGN KEY REFERENCES Seller(sellerId)
);
GO

-- 6. Bảng Cart
CREATE TABLE Cart (
    cartId BIGINT IDENTITY(1,1) PRIMARY KEY,
    userId BIGINT FOREIGN KEY REFERENCES Users(userId),
    buyDate DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1
);
GO

-- 7. Bảng CartItem
CREATE TABLE CartItem (
    cartItemId BIGINT IDENTITY(1,1) PRIMARY KEY,
    quantity INT DEFAULT 1,
    unitPrice DECIMAL(18, 2),
    productId BIGINT FOREIGN KEY REFERENCES Product(productId),
    cartId BIGINT FOREIGN KEY REFERENCES Cart(cartId)
);
GO

-- =================================================================
-- CHÈN DỮ LIỆU MẪU PHONG PHÚ (SEED DATA)
-- =================================================================

-- Thêm Roles
INSERT INTO UserRoles (roleName) VALUES ('ADMIN'), ('USER'), ('SELLER');

-- Thêm Sellers
INSERT INTO Seller (sellerName, images, status) VALUES 
(N'PhongStore - Điện Máy Công Nghệ', 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?w=300', 1),
(N'TechWorld Official Store', 'https://images.unsplash.com/photo-1511556532299-8f662fc26c06?w=300', 1),
(N'Thời Trang & Phong Cách Viễn Đông', 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=300', 1),
(N'Gia Dụng Thông Minh Việt', 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=300', 1);

-- Thêm Users (Mật khẩu mặc định: '123456')
INSERT INTO Users (username, email, fullname, password, status, roleId, sellerId) VALUES 
('admin', 'admin@ute.edu.vn', N'Lê Huỳnh Phong (Admin)', '123456', 1, 1, 1),
('user1', 'user1@gmail.com', N'Nguyễn Văn A', '123456', 1, 2, NULL),
('seller1', 'seller1@gmail.com', N'Trần Văn B', '123456', 1, 3, 2),
('seller2', 'seller2@gmail.com', N'Phạm Thị C', '123456', 1, 3, 3);

-- Thêm Categories
INSERT INTO Category (categoryName, images, status) VALUES 
(N'Điện thoại & Phụ kiện', 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300', 1),
(N'Laptop & Máy tính', 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300', 1),
(N'Thời trang Nam/Nữ', 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300', 1),
(N'Đồ gia dụng thông minh', 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=300', 1),
(N'Đồng hồ & Trang sức', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300', 1),
(N'Thiết bị Âm thanh Hi-Fi', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300', 1),
(N'Phụ kiện Gaming Gear', 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=300', 1);

-- Thêm Products
INSERT INTO Product (productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, sellerId) VALUES 
(N'iPhone 15 Pro Max 256GB Titanium', 'SP-IP15PM', 1, N'Thiết kế khung Titanium siêu bền nhẹ, Chip A17 Pro mạnh mẽ, Hệ thống camera chuyên nghiệp 48MP.', 34990000.00, 15, 100, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', 45, 1, 1),
(N'MacBook Pro 14 inch M3 Pro', 'SP-MBP14M3', 2, N'Màn hình Liquid Retina XDR sắc nét, Chip Apple M3 Pro 11-core CPU, RAM 18GB, SSD 512GB.', 49990000.00, 8, 50, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 30, 1, 1),
(N'Tai nghe Bluetooth Sony WH-1000XM5', 'SP-WH1000XM5', 6, N'Chống ồn chủ động hàng đầu thế giới, thời lượng pin 30 giờ, âm thanh chất lượng cao Hi-Res Audio.', 8490000.00, 25, 200, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 60, 1, 1),
(N'Bàn phím cơ không dây Logitech MX Keys', 'SP-LOGIMX', 7, N'Bàn phím không dây cao cấp thiết kế cho lập trình viên và designer, kết nối đa thiết bị Bluetooth.', 2990000.00, 30, 150, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500', 40, 1, 1),

(N'Laptop Dell XPS 13 Plus 9320', 'SP-DELLXPS13', 2, N'Thiết kế tương lai siêu mỏng nhẹ, Màn hình OLED 3.5K Cảm ứng, Intel Core i7 1360P.', 41500000.00, 5, 30, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 20, 1, 2),
(N'Đồng hồ Samsung Galaxy Watch 6', 'SP-GWATCH6', 5, N'Theo dõi sức khỏe toàn diện, đo điện tâm đồ ECG, thiết kế viền xoay thời trang.', 6990000.00, 18, 80, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500', 15, 1, 2),
(N'Chuột Gaming Razer DeathAdder V3', 'SP-RAZERV3', 7, N'Mắt đọc siêu chính xác Focus Pro 30K, trọng lượng siêu nhẹ 59g cho game thủ Esports chuyên nghiệp.', 3200000.00, 40, 120, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500', 55, 1, 2),

(N'Áo sơ mi Nam Cotton Cao cấp', 'SP-ASMN01', 3, N'Chất liệu 100% Cotton thoáng mát, chống nhăn, kiểu dáng Slim-fit ôm gọn gàng trẻ trung.', 450000.00, 100, 500, 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500', 120, 1, 3),
(N'Áo Khoác Blazer Nữ Phong cách Hàn Quốc', 'SP-BLAZERNU', 3, N'Form áo đứng phom sang trọng, phối đồ linh hoạt từ đi làm đến dạo phố.', 850000.00, 60, 300, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500', 85, 1, 3),

(N'Nồi chiên không dầu Philips XXL 7.3L', 'SP-PHILIPSXXL', 4, N'Công nghệ Rapid Air giòn rụm không cần dầu ăn, dung tích chứa gà nguyên con.', 5490000.00, 12, 45, 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=500', 70, 1, 4),
(N'Robot hút bụi lau nhà Roborock S8 Pro Ultra', 'SP-S8PRO', 4, N'Lực hút cực đại 6000Pa, dock sạc tự động giặt giẻ và sấy khô bằng khí nóng.', 22990000.00, 6, 20, 'https://images.unsplash.com/photo-1589820296156-2454bb8a6ad1?w=500', 95, 1, 4);
GO
