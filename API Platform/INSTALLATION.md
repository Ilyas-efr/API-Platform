# Instructions d'installation

## Prérequis

- PHP 8.1 ou supérieur
- Composer
- MySQL/MariaDB ou PostgreSQL
- Extension PHP : pdo, pdo_mysql (ou pdo_pgsql), mbstring, xml, ctype, iconv

## Étapes d'installation

### 1. Installer les dépendances

```bash
composer install
```

### 2. Configurer la base de données

Créez un fichier `.env.local` à partir de `.env.example` et configurez votre connexion à la base de données :

```bash
# Pour MySQL
DATABASE_URL="mysql://root:password@127.0.0.1:3306/api_platform?serverVersion=8.0&charset=utf8mb4"

# Pour PostgreSQL
DATABASE_URL="postgresql://user:password@127.0.0.1:5432/api_platform?serverVersion=15&charset=utf8"

# Pour SQLite (développement uniquement)
DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
```

### 3. Créer la base de données

```bash
php bin/console doctrine:database:create
```

### 4. Exécuter les migrations

```bash
php bin/console doctrine:migrations:migrate
```

### 5. Lancer le serveur de développement

```bash
# Avec Symfony CLI
symfony server:start

# Ou avec PHP intégré
php -S localhost:8000 -t public
```

### 6. Accéder à la documentation API

Ouvrez votre navigateur et allez sur : **http://localhost:8000/api**

## Structure du projet

- `src/Entity/` - Entités Doctrine (Category, Product)
- `src/Repository/` - Repositories Doctrine
- `config/packages/` - Configuration des bundles
- `migrations/` - Migrations de base de données
- `public/` - Point d'entrée de l'application

## Fonctionnalités implémentées

✅ API RESTful complète avec API Platform
✅ Entités Category et Product avec relation ManyToOne
✅ Validation automatique des données
✅ Format JSON standard (JSON-LD également disponible)
✅ Documentation Swagger interactive
✅ Opérations CRUD complètes (GET, POST, PATCH, DELETE)
✅ Gestion des relations via IRIs
✅ Valeurs par défaut automatiques (createdAt)
✅ Contraintes de validation (NotBlank, UniqueEntity)

## Tests avec Postman ou cURL

### Créer une catégorie
```bash
curl -X POST http://localhost:8000/api/categories \
  -H "Content-Type: application/json" \
  -d '{"title": "Électronique"}'
```

### Créer un produit
```bash
curl -X POST http://localhost:8000/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Smartphone XR",
    "content": "Dernier modèle haute gamme",
    "category": "/api/categories/1"
  }'
```

### Récupérer toutes les catégories
```bash
curl http://localhost:8000/api/categories
```

### Mettre à jour un produit (PATCH)
```bash
curl -X PATCH http://localhost:8000/api/products/1 \
  -H "Content-Type: application/merge-patch+json" \
  -d '{"title": "Nouveau titre"}'
```

