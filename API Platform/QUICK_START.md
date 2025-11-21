# Démarrage Rapide

## ⚡ Installation Automatique

### Option 1 : Script PowerShell (Recommandé)
```powershell
.\install.ps1
```

### Option 2 : Script Batch
```cmd
install.bat
```

### Option 3 : Installation Manuelle

1. **Installer les dépendances**
   ```bash
   composer install
   ```

2. **Configurer la base de données**
   
   Créez un fichier `.env.local` avec :
   ```env
   APP_ENV=dev
   APP_SECRET=change-this-secret-key-in-production
   DATABASE_URL="mysql://root:@127.0.0.1:3306/api_platform?serverVersion=8.0&charset=utf8mb4"
   ```
   
   Ou pour SQLite (plus simple pour tester) :
   ```env
   DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
   ```

3. **Créer la base de données**
   ```bash
   php bin/console doctrine:database:create
   ```

4. **Exécuter les migrations**
   ```bash
   php bin/console doctrine:migrations:migrate
   ```

5. **Lancer le serveur**
   ```bash
   php -S localhost:8000 -t public
   ```

6. **Accéder à la documentation**
   
   Ouvrez votre navigateur : **http://localhost:8000/api**

## 📋 Prérequis

- PHP 8.1 ou supérieur
- Composer
- MySQL/MariaDB ou PostgreSQL (ou SQLite pour les tests)
- Extensions PHP : `pdo`, `pdo_mysql` (ou `pdo_pgsql`), `mbstring`, `xml`, `ctype`, `iconv`

## 🧪 Tester l'API

### Avec cURL

**Créer une catégorie :**
```bash
curl -X POST http://localhost:8000/api/categories \
  -H "Content-Type: application/json" \
  -d "{\"title\": \"Électronique\"}"
```

**Créer un produit :**
```bash
curl -X POST http://localhost:8000/api/products \
  -H "Content-Type: application/json" \
  -d "{\"title\": \"Smartphone XR\", \"content\": \"Dernier modèle\", \"category\": \"/api/categories/1\"}"
```

**Récupérer toutes les catégories :**
```bash
curl http://localhost:8000/api/categories
```

### Avec Postman

1. Importez la collection depuis `/api` (Swagger)
2. Ou créez manuellement les requêtes vers :
   - `GET http://localhost:8000/api/categories`
   - `POST http://localhost:8000/api/categories`
   - `GET http://localhost:8000/api/products`
   - `POST http://localhost:8000/api/products`

## 📚 Documentation

- Documentation API interactive : http://localhost:8000/api
- Voir `README.md` pour plus de détails
- Voir `INSTALLATION.md` pour l'installation complète

