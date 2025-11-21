@echo off
REM Script d'installation pour API Platform (Windows)
REM Exécutez ce script: install.bat

echo === Installation API Platform ===
echo.

REM Vérifier Composer
echo 1. Vérification de Composer...
composer --version >nul 2>&1
if errorlevel 1 (
    echo ERREUR: Composer n'est pas installé ou n'est pas dans le PATH
    echo Veuillez installer Composer depuis https://getcomposer.org/
    pause
    exit /b 1
)
echo Composer trouvé
echo.

REM Vérifier PHP
echo 2. Vérification de PHP...
php -v >nul 2>&1
if errorlevel 1 (
    echo ERREUR: PHP n'est pas installé ou n'est pas dans le PATH
    echo Veuillez installer PHP depuis https://www.php.net/downloads.php
    pause
    exit /b 1
)
echo PHP trouvé
echo.

REM Installer les dépendances
echo 3. Installation des dépendances Composer...
composer install
if errorlevel 1 (
    echo ERREUR lors de l'installation des dépendances
    pause
    exit /b 1
)
echo.

REM Créer .env.local
echo 4. Configuration de l'environnement...
if not exist .env.local (
    if exist .env.example (
        copy .env.example .env.local >nul
        echo Fichier .env.local créé
        echo IMPORTANT: Modifiez .env.local pour configurer votre base de données!
    ) else (
        echo Création manuelle de .env.local requise
    )
) else (
    echo Fichier .env.local existe déjà
)
echo.

REM Créer la base de données
echo 5. Création de la base de données...
php bin/console doctrine:database:create --if-not-exists
if errorlevel 1 (
    echo ATTENTION: Impossible de créer la base de données. Vérifiez votre configuration dans .env.local
) else (
    echo Base de données créée avec succès
)
echo.

REM Exécuter les migrations
echo 6. Exécution des migrations...
php bin/console doctrine:migrations:migrate --no-interaction
if errorlevel 1 (
    echo ATTENTION: Impossible d'exécuter les migrations
) else (
    echo Migrations exécutées avec succès
)
echo.

echo === Installation terminée ===
echo.
echo Pour lancer le serveur de développement:
echo   php -S localhost:8000 -t public
echo.
echo Puis accédez à la documentation API sur:
echo   http://localhost:8000/api
echo.
pause

