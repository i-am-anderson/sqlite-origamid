--
-- 
-- TRIGGER: SÃO UTILIZADOS PARA EXECUTAR AÇÕES AUTOMÁTICAS QUANDO DETERMINADOS EVENTOS ACONTECEM NA TABELA
CREATE TABLE "stats" (
  "name" TEXT PRIMARY KEY,
  "value" INTEGER NOT NULL
) STRICT;

INSERT INTO "stats"
  ("name", "value")
VALUES
  ('user_count', (SELECT COUNT(*) FROM "users"));

-- CRIA UMA TRIGGER QUE ATUALIZA A CONTAGEM DE USUÁRIOS NA TABELA STATS
CREATE TRIGGER "trg_users_insert"
AFTER INSERT ON "users"
BEGIN
  UPDATE "stats" SET "value" = "value" + 1
  WHERE "name" = 'user_count';
END;

SELECT * FROM "stats";

INSERT INTO "users" ("name", "password", "email", "vitalicio") VALUES ('Anderson', '123456', 'anderson@email.com', 1);

SELECT * FROM sqlite_schema;

-- AO DELETAR O USUARIO
CREATE TRIGGER "trg_users_delete"
AFTER DELETE ON "users"
BEGIN
  UPDATE "stats" SET "value" = "value" - 1
  WHERE "name" = 'user_count';
END;

DELETE FROM "users" WHERE "email" = 'anderson@email.com';
-- 
-- 
-- 
-- 
-- UPDATE OF: PODEMOS DISPARAR O TRIGGER QUANDO UMA COLUNA ESPECÍFICA É ALTERADA, USANDO 'UPDATE OF'
-- 
-- 
CREATE TABLE "user_changes" (
  "id" INTEGER PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "old_email" TEXT NOT NULL,
  "new_email" TEXT NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

-- 'OLD' E 'NEW' SÃO PALAVRAS RESERVADAS QUE REPRESENTAM OS VALORES ANTERIORES E OS NOVOS VALORES
CREATE TRIGGER "trg_log_email_change"
BEFORE UPDATE OF "email" ON "users"
WHEN lower(OLD."email") <> lower(NEW."email")
BEGIN
  INSERT INTO "user_changes" ("user_id", "old_email", "new_email")
  VALUES (OLD."id", OLD."email", NEW."email");
END;

UPDATE "users" SET "email" = 'novo2.email@example.com' WHERE "id" = 2;

SELECT * FROM "users";
SELECT * FROM "user_changes";