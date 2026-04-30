#!/bin/bash
# backup/backup.sh : script de sauvegarde logique PostgreSQL pour BetterNetflix

set -e

# Répertoires
ARCHIVE_DIR="$(dirname "$0")/archive"
LOG_DIR="$(dirname "$0")/logs"
LOG_FILE="$LOG_DIR/backup.log"

# Paramètres de connexion
DB_CONTAINER="betternetflix-db"
DB_NAME="betternetflix"
DB_USER="betteruser"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$ARCHIVE_DIR/betternetflix_${DATE}.sql"

# Création des dossiers si besoin
mkdir -p "$ARCHIVE_DIR" "$LOG_DIR"

# Sauvegarde
{
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] Début sauvegarde..."
  docker exec "$DB_CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] Sauvegarde terminée : $BACKUP_FILE"
} >> "$LOG_FILE" 2>&1 || {
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERREUR lors de la sauvegarde !" >> "$LOG_FILE"
  exit 1
}

exit 0
