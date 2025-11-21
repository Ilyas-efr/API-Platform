# Script d'installation pour API Platform
# Exécutez ce script avec PowerShell: .\install.ps1

Write-Host "=== Installation API Platform ===" -ForegroundColor Cyan

# Vérifier si Composer est disponible
Write-Host "`n1. Vérification de Composer..." -ForegroundColor Yellow
try {
    $composerVersion = composer --version 2>&1
    Write-Host "Composer trouvé: $composerVersion" -ForegroundColor Green
} catch {
    Write-Host "ERREUR: Composer n'est pas installé ou n'est pas dans le PATH" -ForegroundColor Red
    Write-Host "Veuillez installer Composer depuis https://getcomposer.org/" -ForegroundColor Yellow
    exit 1
}

# Vérifier si PHP est disponible
Write-Host "`n2. Vérification de PHP..." -ForegroundColor Yellow
try {
    $phpVersion = php -v 2>&1 | Select-Object -First 1
    Write-Host "PHP trouvé: $phpVersion" -ForegroundColor Green
} catch {
    Write-Host "ERREUR: PHP n'est pas installé ou n'est pas dans le PATH" -ForegroundColor Red
    Write-Host "Veuillez installer PHP depuis https://www.php.net/downloads.php" -ForegroundColor Yellow
    exit 1
}

# Installer les dépendances
Write-Host "`n3. Installation des dépendances Composer..." -ForegroundColor Yellow
composer install
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR lors de l'installation des dépendances" -ForegroundColor Red
    exit 1
}

# Créer .env.local si nécessaire
Write-Host "`n4. Configuration de l'environnement..." -ForegroundColor Yellow
if (-not (Test-Path ".env.local")) {
    Copy-Item ".env.example" ".env.local" -ErrorAction SilentlyContinue
    if (Test-Path ".env.local") {
        Write-Host "Fichier .env.local créé à partir de .env.example" -ForegroundColor Green
        Write-Host "IMPORTANT: Modifiez .env.local pour configurer votre base de données!" -ForegroundColor Yellow
    } else {
        Write-Host "Création manuelle de .env.local requise" -ForegroundColor Yellow
    }
} else {
    Write-Host "Fichier .env.local existe déjà" -ForegroundColor Green
}

# Créer la base de données
Write-Host "`n5. Création de la base de données..." -ForegroundColor Yellow
php bin/console doctrine:database:create --if-not-exists
if ($LASTEXITCODE -ne 0) {
    Write-Host "ATTENTION: Impossible de créer la base de données. Vérifiez votre configuration dans .env.local" -ForegroundColor Yellow
} else {
    Write-Host "Base de données créée avec succès" -ForegroundColor Green
}

# Exécuter les migrations
Write-Host "`n6. Exécution des migrations..." -ForegroundColor Yellow
php bin/console doctrine:migrations:migrate --no-interaction
if ($LASTEXITCODE -ne 0) {
    Write-Host "ATTENTION: Impossible d'exécuter les migrations" -ForegroundColor Yellow
} else {
    Write-Host "Migrations exécutées avec succès" -ForegroundColor Green
}

Write-Host "`n=== Installation terminée ===" -ForegroundColor Cyan
Write-Host "`nPour lancer le serveur de développement:" -ForegroundColor Yellow
Write-Host "  php -S localhost:8000 -t public" -ForegroundColor White
Write-Host "`nPuis accédez à la documentation API sur:" -ForegroundColor Yellow
Write-Host "  http://localhost:8000/api" -ForegroundColor White

