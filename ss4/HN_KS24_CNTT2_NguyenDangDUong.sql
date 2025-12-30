CREATE DATABASE school;
USE school;

-- Bảng Student
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)  NOT NULL UNIQUE
);

-- Bảng Course
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

-- Bảng Enrollment
CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    grade DECIMAL(4,2) DEFAULT 0,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);




INSERT INTO Student VALUES
(1, 'Nguyen Van Hoang','hoang@gmail.com','0327610211'),
(2, 'Nguyen Van Long','long@gmail.com','0327610212'),
(3, 'Nguyen Van Hinh','hinh@gmail.com','0327610213'),
(4, 'Nguyen Van Van','van@gmail.com','0327610214'),
(5, 'Nguyen Van Dat','dat@gmail.com','0327610215');


INSERT INTO Course VALUES
(101,'Lap trinh co ban',2),
(102,'Lap trinh nang cao',3),
(103,'Lap trinh C',3),
(104,'Lap trinh Python',2),
(105,'Cau truc du lieu & giai thuat',3);

INSERT INTO Enrollment VALUES
(1,101,7.5),
(2,103,8.0),
(3,102,6.5),
(4,104,9.0),
(5,105,7.0);

UPDATE Enrollment
SET grade = 9.0
WHERE student_id = 2 AND course_id = 103;

SELECT full_name, email, phone
FROM Student;

DELETE FROM Course
WHERE course_id = 101;

-- Nếu không xóa được:
-- Do ràng buộc khóa ngoại CSDL không cho phép xóa
