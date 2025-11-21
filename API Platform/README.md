# API Platform avec Symfony

Guide pratique pour créer des APIs RESTful professionnelles avec API Platform.

## Installation

1. Installer les dépendances :
```bash
composer install
```

2. Configurer la base de données dans le fichier `.env` :
```
DATABASE_URL="mysql://root:@127.0.0.1:3306/api_platform?serverVersion=8.0&charset=utf8mb4"
```

3. Créer la base de données et exécuter les migrations :
```bash
php bin/console doctrine:database:create
php bin/console doctrine:migrations:migrate
```

4. Lancer le serveur de développement :
```bash
symfony server:start
# ou
php -S localhost:8000 -t public
```

## Documentation API

Une fois le serveur lancé, accédez à la documentation interactive Swagger sur :
- **http://localhost:8000/api**

## Endpoints disponibles

### Categories

- `GET /api/categories` - Liste toutes les catégories
- `GET /api/categories/{id}` - Récupère une catégorie spécifique
- `POST /api/categories` - Crée une nouvelle catégorie
- `PATCH /api/categories/{id}` - Met à jour partiellement une catégorie
- `DELETE /api/categories/{id}` - Supprime une catégorie

### Products

- `GET /api/products` - Liste tous les produits
- `GET /api/products/{id}` - Récupère un produit spécifique
- `POST /api/products` - Crée un nouveau produit
- `PATCH /api/products/{id}` - Met à jour partiellement un produit
- `DELETE /api/products/{id}` - Supprime un produit

## Exemples d'utilisation

### Créer une catégorie
```json
POST /api/categories
{
    "title": "Électronique"
}
```

### Créer un produit avec catégorie
```json
POST /api/products
{
    "title": "Smartphone XR",
    "content": "Dernier modèle haute gamme",
    "category": "/api/categories/1"
}
```

## Format de réponse

L'API retourne du JSON standard par défaut. Le format JSON-LD reste disponible pour la compatibilité avec API Platform.

