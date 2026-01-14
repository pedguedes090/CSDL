CREATE PROCEDURE add_user(
  IN p_username VARCHAR(50),
  IN p_email VARCHAR(100),
  IN p_created_at DATE
)
BEGIN
  INSERT INTO users (username, email, created_at)
  VALUES (p_username, p_email, p_created_at);
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS tg_ValidateUser_BeforeInsert;
DELIMITER $$

CREATE TRIGGER tg_ValidateUser_BeforeInsert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  IF NEW.email IS NULL OR NEW.email NOT LIKE '%@%.%' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Email không hợp lệ (phải chứa @ và .)';
  END IF;

  IF NEW.username IS NULL OR NEW.username NOT REGEXP '^[A-Za-z0-9_]+$' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Username không hợp lệ (chỉ cho phép chữ, số và _)';
  END IF;
END$$

DELIMITER ;

CALL add_user('david_01', 'david01@example.com', '2025-02-01');

CALL add_user('bad user', 'baduser@example.com', '2025-02-02');

CALL add_user('baduser', 'baduserexample.com', '2025-02-03');

SELECT * FROM users ORDER BY user_id;