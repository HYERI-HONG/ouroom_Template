CREATE OR REPLACE VIEW post_list_view AS
SELECT A.*, COUNT(c.SEQ) AS COMMENT_CNT
	FROM (
		SELECT
			ROW_NUMBER() OVER(ORDER BY p.SEQ DESC) AS No, p.SEQ, p.TITLE, p.CONTENT, p.REGI_DATE, p.VIEW_CNT, p.LIKE_CNT, p.SHARE_CNT, p.ROOM_TYPE, p.ROOM_SIZE, p.MEM_SEQ, p.IMAGE, p.LAST_UPDATE, m.NICKNAME, m.PROFILE, COUNT(i.SEQ) AS IMGTAG_CNT
		FROM post p
			LEFT JOIN member m ON p.MEM_SEQ LIKE m.SEQ
			LEFT JOIN imgtag i ON p.SEQ LIKE i.POST_SEQ
		GROUP BY p.SEQ
	)A
	LEFT JOIN comment c ON A.SEQ LIKE c.ARTICLE_SEQ
	GROUP BY A.seq
ORDER BY A.No;

CREATE OR REPLACE VIEW post_detail_view AS
SELECT p.SEQ, p.TITLE, p.CONTENT, p.REGI_DATE, p.VIEW_CNT, p.LIKE_CNT, p.SHARE_CNT, p.ROOM_TYPE, p.ROOM_SIZE, p.MEM_SEQ, p.IMAGE, p.LAST_UPDATE, m.NICKNAME, m.PROFILE, COUNT(c.SEQ) AS COMMENT_CNT
FROM post p
	LEFT JOIN member m ON p.MEM_SEQ LIKE m.SEQ
	LEFT JOIN comment c ON p.SEQ LIKE c.ARTICLE_SEQ
GROUP BY p.SEQ
ORDER BY p.SEQ desc;

CREATE OR REPLACE VIEW post_comment_view AS
SELECT 
	c.SEQ, c.COMMENT, c.ARTICLE_SEQ AS POST_SEQ, m.SEQ AS MEM_SEQ ,m.NICKNAME, m.PROFILE 
FROM 
	comment c
JOIN member m ON c.MEM_SEQ LIKE m.SEQ
WHERE c.BOARD_SEQ LIKE 1
ORDER BY c.SEQ DESC;