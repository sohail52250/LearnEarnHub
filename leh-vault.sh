#!/data/data/com.termux/files/usr/bin/bash

VAULT="$HOME/.learn-earnhub-vault"

save(){
echo "$2" > "$VAULT/$1"
echo "Saved: $1"
}

get(){
if [ -f "$VAULT/$1" ]; then
cat "$VAULT/$1"
else
echo "Not found: $1"
fi
}

mkdir -p "$VAULT"
chmod 700 "$VAULT"

case "$1" in

save)
save "$2" "$3"
;;

show)
get "$2"
;;

list)
echo "Stored values:"
ls "$VAULT"
;;

delete)
rm -f "$VAULT/$2"
echo "Deleted: $2"
;;

*)
echo "LearnEarnHub Vault"
echo ""
echo "Save:"
echo " leh-vault.sh save NAME VALUE"
echo ""
echo "Show:"
echo " leh-vault.sh show NAME"
echo ""
echo "List:"
echo " leh-vault.sh list"
echo ""
echo "Delete:"
echo " leh-vault.sh delete NAME"
;;

esac
