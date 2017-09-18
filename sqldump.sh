function db_dump_base() {
	project="$1"
	dbuser="$2"
	dbpass="$3"
	filename="$project`date +%Y%m%d%H%M`.sql"
	umask 077 ; mysqldump -u"$dbuser" -p"$dbpass" --databases "$project" > ~/sqldump/"$filename" ; umask 022
	(cd ~/sqldump/$project/.git &&
	 cd .. &&
	 git diff --quiet &&
	 mv "../$filename" "$project.sql" &&
	 ([ -x clean.sh ] && ./clean.sh;
	  git add "$project.sql" &&
	  git commit -qm "Update $project.sql")) || echo "sqldump.sh: Failed to commit"
}
