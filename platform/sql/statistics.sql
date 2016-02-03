use information_schema;

SELECT table_name,table_rows FROM tables 
WHERE TABLE_SCHEMA = 'enjoymi_platform' AND table_name LIKE 'tbl_account%'
ORDER BY table_rows DESC;

-- 统计账号注册总数
SELECT sum(table_rows) AS `注册账号数` FROM tables 
WHERE TABLE_SCHEMA = 'enjoymi_platform' AND table_name LIKE 'tbl_account%';

SELECT table_name,table_rows FROM tables 
WHERE TABLE_SCHEMA = 'enjoymi_platform' AND table_name LIKE 'tbl_tokencache%'
ORDER BY table_rows DESC;

-- 统计token存储总数
SELECT sum(table_rows) AS `token总数` FROM tables 
WHERE TABLE_SCHEMA = 'enjoymi_platform' AND table_name LIKE 'tbl_tokencache%';
