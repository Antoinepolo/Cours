SELECT * FROM users WHERE age > 99;

CREATE INDEX select_users ON users(age) WHERE age > 99;

DROP INDEX select_users ON users;

SELECT i.[name] AS IndexName
    ,SUM(s.[used_page_count]) * 8 AS IndexSizeKB
FROM sys.dm_db_partition_stats AS s
INNER JOIN sys.indexes AS i ON s.[object_id] = i.[object_id]
    AND s.[index_id] = i.[index_id]
GROUP BY i.[name]
ORDER BY i.[name]
GO

-- Le premier index est beaucoup plus lourd que le deuxième