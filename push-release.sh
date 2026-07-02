#!/bin/bash

# 1. Récupérer automatiquement la version du package.json
VERSION=$(node -p "require('./package.json').version")
TAG="v$VERSION"

echo "Version détectée : $VERSION"

# --- MODIFICATION ICI ---
# Vérifie si un argument a été passé au script
if [ -z "$1" ]; then
    COMMIT_MSG="Bump version to $VERSION"
else
    COMMIT_MSG="Bump version to $VERSION - $1"
fi
# ------------------------

# 2. Ajouter et commit les fichiers modifiés
git add .
echo "Commit des changements..."
git commit -m "$COMMIT_MSG"

# 3. Pousser la branche principale
echo "Push vers la branche main..."
git push origin main

# 4. Supprimer le tag local et distant s'il existe déjà (pour éviter les doublons)
echo "Nettoyage de l'ancien tag $TAG..."
git tag -d $TAG 2>/dev/null
git push --delete origin $TAG 2>/dev/null

# 5. Créer et pousser le nouveau tag
echo "Création et push du tag $TAG..."
git tag $TAG
git push origin $TAG

echo "Tout est envoyé ! Surveille l'onglet Actions sur GitHub."
