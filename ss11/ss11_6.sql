DELIMITER //

CREATE PROCEDURE NotifyFriendsOnNewPost (
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE v_full_name VARCHAR(255);

    -- Lấy tên người đăng
    SELECT full_name
    INTO v_full_name
    FROM users
    WHERE user_id = p_user_id;

    -- Thêm bài viết mới
    INSERT INTO posts (user_id, content, created_at)
    VALUES (p_user_id, p_content, NOW());

    -- Gửi thông báo cho bạn bè đã accepted
    INSERT INTO notifications (user_id, type, content, created_at)
    SELECT
        CASE
            WHEN f.user_id = p_user_id THEN f.friend_id
            ELSE f.user_id
        END AS receiver_id,
        'new_post',
        CONCAT(v_full_name, ' đã đăng một bài viết mới'),
        NOW()
    FROM friends f
    WHERE f.status = 'accepted'
      AND (f.user_id = p_user_id OR f.friend_id = p_user_id)
      AND (
            CASE
                WHEN f.user_id = p_user_id THEN f.friend_id
                ELSE f.user_id
            END
          ) <> p_user_id;
END //

DELIMITER ;


CALL NotifyFriendsOnNewPost(
    1,
    'Hôm nay mình vừa học xong Stored Procedure trong MySQL!'
);
SELECT *
FROM posts
ORDER BY post_id DESC;

SELECT *
FROM notifications
ORDER BY created_at DESC;

