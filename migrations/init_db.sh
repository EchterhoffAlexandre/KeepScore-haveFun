# donner les droits d'exécution du fichier :
# chmod +x init_db.sh 


# Je prends l'identité de spedata :
export PGUSER=admin_kshf

# Je supprime la BDD ocolis et l'utilisateur KSHF
dropdb KSHF
echo "BDD supprimée"
dropuser admin_kshf
echo "admin_kshf supprimé"

# Je crèe la BDD ocolis et l'utilisateur KSHF
createuser admin_kshf -P
echo "admin_kshf créé"
createdb KSHF -O admin_kshf
echo "BDD créée"

# Je supprime sqitch.conf et sqitch.plan
rm sqitch.conf
rm sqitch.plan

# J'initiase Sqitch
sqitch init KSHF --target db:pg:KSHF
echo "Sqitch initialisé"