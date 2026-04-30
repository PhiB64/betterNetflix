# betterNetflix

## Sauvegarde et restauration de la base de données

- Le script de sauvegarde se trouve dans `backup/backup.sh`.
- Les sauvegardes sont générées dans le dossier `backup/archive/`.
- Les logs sont stockés dans `backup/logs/`.
- Les dossiers `backup/archive/` et `backup/logs/` sont ignorés par git (voir `.gitignore`).

### Lancer une sauvegarde

```bash
./backup/backup.sh
```

Un fichier de sauvegarde sera créé dans `backup/archive/`.


### Restaurer la base de données

Pour restaurer la base à partir d’une sauvegarde, il est recommandé de repartir d’une base vide :

1. **Supprimer la base existante** (attention, cela efface toutes les données actuelles) :

```bash
docker exec -it betternetflix-db psql -U betteruser -d postgres -c "DROP DATABASE betternetflix;"
```

2. **Recréer la base** :

```bash
docker exec -it betternetflix-db psql -U betteruser -d postgres -c "CREATE DATABASE betternetflix;"
```

3. **Restaurer la sauvegarde** :

```bash
docker exec -i betternetflix-db psql -U betteruser -d betternetflix < backup/archive/betternetflix_20260430_112555.sql
```

Adapte le nom du fichier de sauvegarde si besoin. Cette procédure garantit une restauration sans conflit.


