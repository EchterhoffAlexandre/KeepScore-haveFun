# Je prends l'identité de spedata :
export PGUSER=admin_kshf

# Je supprime la BDD kshf
dropdb kshf

# Je crèe la BDD kshf
createdb kshf

# Je me place sur la BDD kshf (variable d'environnement)
export PGDATABASE=kshf

psql -f ./migrations/deploy/1.create_tables.sql
