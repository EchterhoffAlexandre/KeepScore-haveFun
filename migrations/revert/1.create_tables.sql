-- Revert KSHF:1.create_tables from pg

BEGIN;

DROP TABLE shop,collection,quest,transaction,user_has_friend,"user" CASCADE;


COMMIT;
