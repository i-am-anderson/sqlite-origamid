--
-- 
-- 
SELECT COUNT(*) FROM "certificates";      -- 17102540
SELECT COUNT(*) FROM "courses";           -- 20
SELECT COUNT(*) FROM "lessons";           -- 200
SELECT COUNT(*) FROM "lessons_completed"; -- 75181942
SELECT COUNT(*) FROM "products";          -- 1000000
SELECT COUNT(*) FROM "users";             -- 879138
-- 
-- 
-- INDEX: OS ÍNDICES SÃO UTILIZADOS PARA ACELERAR A BUSCA DE DADOS EM TABELAS. SÃO AUTOMATICAMENTE CRIADOS PARA COLUNAS QUE SÃO PRIMARY KEY OU UNIQUE, MAS TAMBÉM PODEM SER CRIADOS MANUALMENTE PARA OUTRAS COLUNAS.
-- 
-- 
-- USAR O INDEX PARA FAZER A BUSCA
SELECT * FROM "users" WHERE "id" = 50000;
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "id" = 50000;
-- 
-- USAR O INDEX PARA FAZER A BUSCA
SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';
-- 
-- SCAN USERS PARA FAZER A BUSCA
SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';
-- 
-- SCAN USERS, NÃO USA INDEX
SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09';
-- 
-- 
-- 
-- PRAGMA: É POSSÍVEL VERIFICAR AS CARACTERÍSTICAS USANDO O 'PRAGMA index_info'
-- 
SELECT * FROM "sqlite_schema";
SELECT * FROM "sqlite_schema" WHERE "type" = 'index';
PRAGMA index_list('certificates');
PRAGMA index_info('sqlite_autoindex_certificates_2');
PRAGMA index_xinfo('sqlite_autoindex_certificates_2');
