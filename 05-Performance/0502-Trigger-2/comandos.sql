--
-- 
-- TRIGGER COMPLEXOS: CONDIÇÕES MAIS COMPLEXAS PARA O 'WHEN'
SELECT COUNT(*) FROM "lessons_completed"
WHERE "user_id" = 1 AND "course_id" = 1;

SELECT COUNT(*) FROM "lessons"
WHERE "course_id" = 1;

CREATE TRIGGER "trg_create_certificate"
AFTER INSERT ON "lessons_completed"
WHEN (
  (SELECT COUNT(*) FROM "lessons_completed"
   WHERE "user_id" = NEW."user_id" AND "course_id" = NEW."course_id")
  =
  (SELECT COUNT(*) FROM "lessons"
   WHERE "course_id" = NEW."course_id")
)
BEGIN
  INSERT OR IGNORE INTO "certificates" ("id", "user_id", "course_id")
  VALUES (lower(hex(randomblob(16))), NEW."user_id", NEW."course_id");
END;

SELECT * FROM sqlite_schema WHERE "type" = 'trigger';

INSERT INTO "users" ("name", "password", "email", "vitalicio") VALUES ('And', '123456', 'and@email.com', 1);

INSERT INTO "lessons_completed"
  ("user_id", "course_id", "lesson_id")
values
  (1032765, 2, 1),
  (1032765, 2, 2),
  (1032765, 2, 3),
  (1032765, 2, 4),
  (1032765, 2, 5);

SELECT * FROM "certificates" WHERE "user_id" = 1032765;


-- 
-- 
-- 
-- 
-- DROP TRIGGER: PARA LISTAR OS TRIGGERS EXISTENTES, PODEMOS CONSULTAR A TABELA 'sqlite_schema' E PODEMOS DELETAR UM TRIGGER ESPECÍFICO USANDO 'DROP TRIGGER'
-- 
-- 
SELECT * FROM 'sqlite_schema' WHERE "type" = 'trigger';

DROP TRIGGER "trg_create_certificate";
