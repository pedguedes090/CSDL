CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày

-- Phần 1
-- câu 1
select guest_id , phone 
from guests;

-- câu 2
select room_type 
from rooms;

-- câu 3
select room_type , price_per_day 
from rooms
order by price_per_day asc;

-- câu 4
select room_id, room_type, price_per_day
from rooms
where price_per_day > 1000000;

-- câu 5
select *
from bookings
where check_in < '2025-01-01' and check_out >= '2024-01-01';

-- câu 6
select room_type, COUNT(*) AS room_count
from rooms
group by room_type;


-- Phần 2
-- câu 1
select b.booking_id,
    g.guest_name,
    r.room_type,
    b.check_in
from bookings b
join guests g on g.guest_id = b.guest_id
join rooms r on r.room_id = b.room_id
order by b.check_in, b.booking_id;

-- câu 2
select g.guest_id,
    g.guest_name,
    COUNT(b.booking_id) booking_count
from guests g
left join bookings b on b.guest_id = g.guest_id
group by g.guest_id, g.guest_name
order by booking_count desc, g.guest_id;

-- câu 3
SELECT r.room_id, r.room_type,
       COUNT(*) * r.price_per_day AS doanh_thu
FROM rooms r
JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_type, r.price_per_day;

-- Câu 4
SELECT guest_name, COUNT(*) AS total_bookings
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_name
HAVING COUNT(*) >= 2;

-- Câu 5
SELECT r.room_type, COUNT(*) AS total_bookings
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type
ORDER BY total_bookings DESC
LIMIT 1;


-- Phần 3
-- câu 1
SELECT room_id, room_type, price_per_day
FROM rooms
WHERE price_per_day > (SELECT AVG(price_per_day) FROM rooms)
ORDER BY price_per_day DESC, room_id;

-- câu 2
SELECT g.guest_id, g.guest_name, g.phone
FROM guests g
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.guest_id = g.guest_id
)
ORDER BY g.guest_id;

-- câu 3
WITH room_counts AS (
    SELECT r.room_id, r.room_type, r.price_per_day, COUNT(b.booking_id) AS cnt
    FROM rooms r
    LEFT JOIN bookings b ON b.room_id = r.room_id
    GROUP BY r.room_id, r.room_type, r.price_per_day
)
SELECT room_id, room_type, price_per_day, cnt
FROM room_counts
WHERE cnt = (SELECT MAX(cnt) FROM room_counts);
